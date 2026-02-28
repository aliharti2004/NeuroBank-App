package com.banque.service;

import com.banque.dao.*;
import com.banque.model.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.net.URI;
import java.net.http.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.Map;

public class IAIServiceImpl implements IAIService {
    private IClientDAO clientDAO = new ClientDAOImpl();
    private static final String AI_URL = "http://localhost:5000/predict";

    @Override
    public PredictionIA analyserDemande(DemandePret d) {
        try {
            // 1. Récupération sécurisée du client
            Client c = clientDAO.findById(d.getIdClient());
            if (c == null) {
                throw new Exception("Client introuvable en base pour l'ID : " + d.getIdClient());
            }

            BigDecimal revenu = c.getRevenuMensuel();
            if (revenu == null || revenu.compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("Données financières insuffisantes (revenu nul ou inexistant).");
            }

            // 2. Préparation du ratio d'endettement (Exigence 4.2.5)
            // Formule : (Mensualité / Revenu)
            BigDecimal ratio = d.getMontantPret().divide(revenu, 4, RoundingMode.HALF_UP);

            // 3. Création du JSON via une Map (plus propre que String.format)
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> dataIA = new HashMap<>();
            dataIA.put("revenu", revenu);
            dataIA.put("mensualite", d.getMensualite() != null ? d.getMensualite() : d.getMontantPret()); // Mensualité
                                                                                                          // calculée
            dataIA.put("duree", d.getDureeMois());
            dataIA.put("taux", d.getTauxInteret());
            dataIA.put("ville", c.getVille() != null ? c.getVille() : "INCONNUE");
            dataIA.put("type_pret", d.getTypePret() != null ? d.getTypePret() : "immobilier"); // Type de prêt
            dataIA.put("ratio", ratio);

            String jsonInput = mapper.writeValueAsString(dataIA);

            // 4. Appel HTTP vers le module Python (Inférence)
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(AI_URL))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(jsonInput))
                    .build();

            // Timeout de 5 secondes pour ne pas bloquer l'app si Python est lent
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            // 5. Mapping de la réponse JSON vers l'objet PredictionIA
            if (response.statusCode() == 200) {
                PredictionIA p = mapper.readValue(response.body(), PredictionIA.class);
                p.setIdDemande(d.getIdDemande());
                return p;
            } else {
                throw new Exception("Le serveur IA a répondu avec l'erreur : " + response.statusCode());
            }

        } catch (Exception e) {
            // Log détaillé pour le débogage
            System.err.println("IA SERVICE ERROR : " + e.getMessage());
            return createFallbackPrediction(d.getIdDemande(), e.getMessage());
        }
    }

    private PredictionIA createFallbackPrediction(int idDemande, String errorMsg) {
        PredictionIA p = new PredictionIA();
        p.setIdDemande(idDemande);
        p.setScoreRisque(0);
        p.setProbabiliteDefaut(BigDecimal.ZERO);
        p.setRecommandation("ERREUR IA (" + errorMsg + ") : Analyse manuelle par l'agent requise.");
        return p;
    }
}