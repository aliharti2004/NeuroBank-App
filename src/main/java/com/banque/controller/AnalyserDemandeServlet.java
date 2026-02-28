package com.banque.controller;

import java.io.IOException;
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

import org.json.JSONObject;

/**
 * Servlet pour déclencher une analyse IA à la demande (AJAX)
 */
@WebServlet("/agent/analyser-demande")
public class AnalyserDemandeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IDemandePretDAO demandeDAO;
    private IAAnalysisService iaService;

    public AnalyserDemandeServlet() {
        this.demandeDAO = new DemandePretDAOImpl();
        this.iaService = new IAAnalysisService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session agent
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (user == null || !"AGENT".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Non autorisé\"}");
            return;
        }

        try {
            int idDemande = Integer.parseInt(request.getParameter("idDemande"));

            // Récupérer la demande
            DemandePret demande = demandeDAO.findById(idDemande);

            if (demande == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Demande non trouvée\"}");
                return;
            }

            System.out.println("🤖 Analyse IA déclenchée manuellement pour demande #" + idDemande);

            // Analyser avec IA
            PredictionIA prediction = iaService.analyzerDemande(demande);

            if (prediction != null && prediction.getScoreRisque() >= 0) {
                // Succès
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("scoreRisque", prediction.getScoreRisque());
                jsonResponse.put("probabiliteDefaut", prediction.getProbabiliteDefaut().doubleValue());
                jsonResponse.put("recommandation", prediction.getRecommandation());

                // Déterminer la catégorie de risque
                String categorieRisque;
                if (prediction.getScoreRisque() < 30) {
                    categorieRisque = "low";
                } else if (prediction.getScoreRisque() < 60) {
                    categorieRisque = "medium";
                } else {
                    categorieRisque = "high";
                }
                jsonResponse.put("categorieRisque", categorieRisque);

                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(jsonResponse.toString());

                System.out.println("✅ Analyse réussie - Score: " + prediction.getScoreRisque() + "/100");

            } else {
                // Échec
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("error", "L'analyse IA a échoué. Vérifiez que l'API Flask est démarrée.");
                response.getWriter().write(jsonResponse.toString());
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"ID demande invalide\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Erreur serveur: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
            e.printStackTrace();
        }
    }
}
