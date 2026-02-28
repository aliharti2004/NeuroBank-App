package com.banque.test;

import com.banque.model.DemandePret;
import com.banque.model.PredictionIA;
import com.banque.service.IPretService;
import com.banque.service.PretServiceImpl;
import com.banque.dao.IPredictionDAO;
import com.banque.dao.PredictionDAOImpl;
import java.math.BigDecimal;

public class MainTestAIIntegration {
    public static void main(String[] args) {
        System.out.println("--- DÉBUT DU TEST D'INTÉGRATION IA & SERVICE ---");

        IPretService pretService = new PretServiceImpl();
        IPredictionDAO predictionDAO = new PredictionDAOImpl();

        try {
            // 1. Préparation d'une demande de test
            DemandePret d = new DemandePret();
            d.setIdClient(1); // Assurez-vous que l'ID 1 existe en base (t_client)
            d.setTypePret("immobilier");
            d.setMontantPret(new BigDecimal("350000.00"));
            d.setDureeMois(120);
            d.setTauxInteret(new BigDecimal("4.2"));

            // 2. Exécution du service (Calcul + Insert + Appel IA)
            System.out.println("[Étape 1] Soumission de la demande...");
            DemandePret result = pretService.soumettreNouvelleDemande(d);
            System.out.println("SUCCÈS : Demande enregistrée avec l'ID " + result.getIdDemande());

            // 3. Vérification de la prédiction en base de données
            System.out.println("\n[Étape 2] Vérification de la prédiction associée...");
            PredictionIA pred = predictionDAO.findByDemandeId(result.getIdDemande());

            if (pred != null) {
                System.out.println("SUCCÈS : Une prédiction a été trouvée pour cette demande !");
                System.out.println("Verdict IA : " + pred.getRecommandation());
            } else {
                System.out.println("ALERTE : Aucune prédiction trouvée. Vérifiez le log du IAIService.");
            }

        } catch (Exception e) {
            System.err.println("ÉCHEC DU TEST : " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("\n--- FIN DU TEST D'INTÉGRATION ---");
    }
}