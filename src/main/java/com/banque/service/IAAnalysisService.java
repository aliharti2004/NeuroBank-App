package com.banque.service;

import com.banque.dao.IClientDAO;
import com.banque.dao.ClientDAOImpl;
import com.banque.dao.IPredictionDAO;
import com.banque.dao.PredictionDAOImpl;
import com.banque.model.Client;
import com.banque.model.DemandePret;
import com.banque.model.PredictionIA;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * Service d'analyse IA utilisant le modèle de réseau de neurones Flask
 * API Flask: http://localhost:5000/predict
 */
public class IAAnalysisService {

    private static final String IA_API_URL = "http://localhost:5000/predict";
    private static final int TIMEOUT_MS = 10000; // 10 secondes

    private IPredictionDAO predictionDAO;
    private IClientDAO clientDAO;

    public IAAnalysisService() {
        this.predictionDAO = new PredictionDAOImpl();
        this.clientDAO = new ClientDAOImpl();
    }

    /**
     * Analyse une demande de prêt via l'API Flask et sauvegarde la prédiction
     * 
     * @param demande La demande à analyser
     * @return L'objet PredictionIA créé, ou null en cas d'erreur
     */
    public PredictionIA analyzerDemande(DemandePret demande) {
        try {
            // 1. Récupérer les données du client
            Client client = clientDAO.findById(demande.getIdClient());
            if (client == null) {
                System.err.println("⚠️ Client introuvable pour la demande #" + demande.getIdDemande());
                return createErrorPrediction(demande.getIdDemande(), "Client non trouvé");
            }

            // 2. Calculer la mensualité si elle n'existe pas
            double revenu = client.getRevenuMensuel().doubleValue();
            double mensualite;

            if (demande.getMensualite() != null) {
                mensualite = demande.getMensualite().doubleValue();
            } else {
                // Calcul approximatif de la mensualité (formule simplifiée)
                double montant = demande.getMontantPret().doubleValue();
                int dureeAnnees = demande.getDureeMois() / 12;
                // Avoid division by zero if dureeMois is 0 or too small
                if (dureeAnnees == 0) {
                    dureeAnnees = 1; // Assume at least 1 year for calculation if duration is very short
                }
                mensualite = montant / (dureeAnnees * 12);
                System.out.println("ℹ️ Mensualité calculée: " + mensualite);
            }

            double ratio = mensualite / revenu;

            // 3. Préparer les données pour l'API Flask
            JSONObject requestData = new JSONObject();
            requestData.put("revenu", revenu);
            requestData.put("mensualite", mensualite);
            requestData.put("duree", demande.getDureeMois());
            requestData.put("taux", demande.getTauxInteret().doubleValue());
            requestData.put("ville", client.getVille().toUpperCase());
            requestData.put("type_pret", demande.getTypePret());
            requestData.put("ratio", ratio);

            System.out.println("📤 Envoi à l'IA: " + requestData.toString());

            // 4. Appeler l'API Flask
            JSONObject response = callFlaskAPI(requestData);

            if (response == null) {
                return createErrorPrediction(demande.getIdDemande(), "API Flask indisponible");
            }

            // 5. Créer l'objet PredictionIA
            PredictionIA prediction = new PredictionIA();
            prediction.setIdDemande(demande.getIdDemande());
            prediction.setScoreRisque(response.getInt("scoreRisque"));
            prediction.setProbabiliteDefaut(new BigDecimal(response.getDouble("probabiliteDefaut")));
            prediction.setRecommandation(response.getString("recommandation"));

            // 6. Sauvegarder en base de données (INSERT ou UPDATE si existe déjà)
            try {
                // Vérifier si une prédiction existe déjà
                PredictionIA existing = predictionDAO.findByDemandeId(demande.getIdDemande());
                if (existing != null) {
                    // Mise à jour
                    prediction.setIdPrediction(existing.getIdPrediction());
                    predictionDAO.update(prediction);
                    System.out.println("🔄 Prédiction mise à jour");
                } else {
                    // Insertion
                    predictionDAO.insert(prediction);
                    System.out.println("➕ Nouvelle prédiction créée");
                }
            } catch (Exception e) {
                // En cas d'erreur de contrainte, essayer UPDATE
                System.out.println("⚠️ Tentative de mise à jour après erreur insertion: " + e.getMessage());
                PredictionIA existing = predictionDAO.findByDemandeId(demande.getIdDemande());
                if (existing != null) {
                    prediction.setIdPrediction(existing.getIdPrediction());
                    predictionDAO.update(prediction);
                    System.out.println("🔄 Prédiction mise à jour après échec d'insertion");
                } else {
                    System.err
                            .println("❌ Échec de l'insertion et de la mise à jour de la prédiction: " + e.getMessage());
                    throw e; // Re-throw if neither insert nor update worked
                }
            }

            System.out.println("✅ Analyse IA réussie pour demande #" + demande.getIdDemande()
                    + " - Score: " + prediction.getScoreRisque() + "/100");

            return prediction;

        } catch (Exception e) {
            System.err.println("❌ Erreur analyse IA demande #" + demande.getIdDemande() + ": " + e.getMessage());
            e.printStackTrace();
            return createErrorPrediction(demande.getIdDemande(), "Erreur: " + e.getMessage());
        }
    }

    /**
     * Appel HTTP POST vers l'API Flask
     * 
     * @param data Les données JSON à envoyer
     * @return La réponse JSON de l'API, ou null en cas d'erreur
     */
    private JSONObject callFlaskAPI(JSONObject data) {
        HttpURLConnection conn = null;
        try {
            // Créer la connexion
            URL url = new URL(IA_API_URL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setConnectTimeout(TIMEOUT_MS);
            conn.setReadTimeout(TIMEOUT_MS);
            conn.setDoOutput(true);

            // Envoyer les données
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = data.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Lire la réponse
            int responseCode = conn.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    StringBuilder response = new StringBuilder();
                    String responseLine;
                    while ((responseLine = br.readLine()) != null) {
                        response.append(responseLine.trim());
                    }

                    System.out.println("📥 Réponse IA: " + response.toString());
                    return new JSONObject(response.toString());
                }
            } else {
                System.err.println("⚠️ API Flask erreur HTTP: " + responseCode);
                return null;
            }

        } catch (java.net.ConnectException e) {
            System.err
                    .println("⚠️ Impossible de se connecter à l'API Flask. Est-elle démarrée sur " + IA_API_URL + " ?");
            return null;
        } catch (Exception e) {
            System.err.println("⚠️ Erreur appel API Flask: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    /**
     * Crée une prédiction d'erreur pour sauvegarder en DB
     * 
     * @param idDemande    ID de la demande
     * @param errorMessage Message d'erreur
     * @return Objet PredictionIA avec erreur
     */
    private PredictionIA createErrorPrediction(int idDemande, String errorMessage) {
        PredictionIA errorPred = new PredictionIA();
        errorPred.setIdDemande(idDemande);
        errorPred.setScoreRisque(0);
        errorPred.setProbabiliteDefaut(BigDecimal.ZERO);
        errorPred.setRecommandation("ERREUR IA : " + errorMessage + " - Analyse manuelle requise.");

        try {
            predictionDAO.insert(errorPred);
        } catch (Exception e) {
            System.err.println("❌ Impossible de sauvegarder la prédiction d'erreur: " + e.getMessage());
        }

        return errorPred;
    }
}
