package com.banque.service;

import com.banque.dao.*;
import com.banque.model.Client;
import com.banque.model.DemandePret;
import com.banque.model.PredictionIA;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Implémentation de la couche Service pour la gestion des prêts.
 * Centralise la logique métier bancaire et l'orchestration avec l'IA.
 */
public class PretServiceImpl implements IPretService {

    // Dépendances DAO
    private IDemandePretDAO demandeDAO = new DemandePretDAOImpl();
    private IClientDAO clientDAO = new ClientDAOImpl();

    // Service IA - Integration Flask ML Model
    private IAAnalysisService iaService = new IAAnalysisService();

    /**
     * Soumet une nouvelle demande de prêt :
     * - validation métier
     * - calcul de la mensualité
     * - persistance
     * - analyse IA
     */
    @Override
    public DemandePret soumettreNouvelleDemande(DemandePret demande) {

        // =========================
        // 1. RÉCUPÉRATION CLIENT
        // =========================
        Client client = clientDAO.findById(demande.getIdClient());

        if (client == null || client.getRevenuMensuel() == null) {
            throw new IllegalStateException(
                    "Les informations financières du client sont incomplètes.");
        }

        // =========================
        // 2. CALCUL DE LA MENSUALITÉ
        // =========================
        BigDecimal mensualite = calculerMensualite(
                demande.getMontantPret(),
                demande.getTauxInteret(),
                demande.getDureeMois());

        demande.setMensualite(mensualite);

        System.out.println("Service : Mensualité calculée = " + mensualite + " €");

        // =========================
        // 3. CONTRÔLE MÉTIER
        // Règle bancaire : mensualité ≤ 40 % du revenu
        // =========================
        BigDecimal seuilEndettement = client.getRevenuMensuel()
                .multiply(BigDecimal.valueOf(0.40));

        if (mensualite.compareTo(seuilEndettement) > 0) {
            throw new IllegalStateException(
                    "Demande refusée : taux d'endettement trop élevé.");
        }

        // =========================
        // 4. PERSISTANCE DEMANDE
        // (Assignation automatique agent dans le DAO)
        // =========================
        DemandePret demandeEnregistree = demandeDAO.insert(demande);

        System.out.println(
                "Service : Demande enregistrée avec ID " + demandeEnregistree.getIdDemande());

        // =========================
        // 5. ANALYSE IA FLASK - RÉSEAU DE NEURONES
        // =========================
        try {
            System.out.println("🤖 Lancement analyse IA Flask pour demande #" + demandeEnregistree.getIdDemande());
            PredictionIA prediction = iaService.analyzerDemande(demandeEnregistree);

            if (prediction != null) {
                System.out.println("✅ Analyse IA réussie - Score: " + prediction.getScoreRisque() + "/100");
            } else {
                System.out.println("⚠️ Analyse IA retour null - Prédiction d'erreur sauvegardée");
            }
        } catch (Exception e) {
            System.err.println("⚠️ Erreur analyse IA (non bloquante): " + e.getMessage());
            // Ne pas bloquer la création de la demande si l'IA échoue
        }

        return demandeEnregistree;
    }

    /**
     * Calcul financier de la mensualité d'un prêt amortissable.
     *
     * Formule :
     * M = P × [ r / (1 − (1 + r)^(-n)) ]
     */
    private BigDecimal calculerMensualite(
            BigDecimal capital,
            BigDecimal tauxAnnuel,
            int dureeMois) {

        double p = capital.doubleValue();
        double r = tauxAnnuel.doubleValue() / 12 / 100;
        int n = dureeMois;

        double mensualite = (p * r) / (1 - Math.pow(1 + r, -n));

        return BigDecimal.valueOf(mensualite)
                .setScale(2, RoundingMode.HALF_UP);
    }
}
