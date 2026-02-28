package com.banque.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.dao.DemandePretDAOImpl;
import com.banque.dao.IDemandePretDAO;
import com.banque.model.DemandePret;
import com.banque.model.PredictionIA;
import com.banque.model.Utilisateur;
import com.banque.service.IAAnalysisService;

/**
 * Servlet pour analyser toutes les demandes EN_ATTENTE en masse avec le modèle
 * IA
 */
@WebServlet("/agent/analyser-tout")
public class AnalyserToutesDemandesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IDemandePretDAO demandeDAO;
    private IAAnalysisService iaService;

    public AnalyserToutesDemandesServlet() {
        this.demandeDAO = new DemandePretDAOImpl();
        this.iaService = new IAAnalysisService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session agent
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user == null || !"AGENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        System.out.println("🤖 ========================================");
        System.out.println("🤖 DÉMARRAGE ANALYSE IA EN MASSE");
        System.out.println("🤖 ========================================");

        long startTime = System.currentTimeMillis();

        // Récupérer toutes les demandes EN_ATTENTE
        List<DemandePret> demandes = demandeDAO.findAll();
        List<DemandePret> demandesEnAttente = demandes.stream()
                .filter(d -> "EN_ATTENTE".equals(d.getStatut()))
                .collect(java.util.stream.Collectors.toList());

        int total = demandesEnAttente.size();
        int successes = 0;
        int failures = 0;

        System.out.println("📊 Nombre de demandes à analyser: " + total);

        // Analyser chaque demande
        for (int i = 0; i < demandesEnAttente.size(); i++) {
            DemandePret demande = demandesEnAttente.get(i);

            try {
                System.out.println("\n[" + (i + 1) + "/" + total + "] Analyse demande #" + demande.getIdDemande());

                PredictionIA prediction = iaService.analyzerDemande(demande);

                if (prediction != null && prediction.getScoreRisque() > 0) {
                    successes++;
                    System.out.println("✅ Succès - Score: " + prediction.getScoreRisque() + "/100");
                } else {
                    failures++;
                    System.out.println("⚠️ Échec - Prédiction nulle ou invalide");
                }

                // Petit délai pour ne pas surcharger l'API Flask
                Thread.sleep(100);

            } catch (Exception e) {
                failures++;
                System.err.println("❌ Erreur: " + e.getMessage());
            }
        }

        long endTime = System.currentTimeMillis();
        long duration = (endTime - startTime) / 1000; // en secondes

        System.out.println("\n🤖 ========================================");
        System.out.println("🤖 FIN ANALYSE IA EN MASSE");
        System.out.println("🤖 ========================================");
        System.out.println("📊 Total analysé: " + total);
        System.out.println("✅ Succès: " + successes);
        System.out.println("❌ Échecs: " + failures);
        System.out.println("⏱️ Durée: " + duration + " secondes");
        System.out.println("🤖 ========================================\n");

        // Passer les résultats à la session pour affichage
        session.setAttribute("ia_analysis_total", total);
        session.setAttribute("ia_analysis_success", successes);
        session.setAttribute("ia_analysis_failures", failures);
        session.setAttribute("ia_analysis_duration", duration);

        // Rediriger vers le dashboard
        response.sendRedirect(request.getContextPath() + "/agent/dashboard");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Rediriger POST pour éviter access GET
        response.sendRedirect(request.getContextPath() + "/agent/dashboard");
    }
}
