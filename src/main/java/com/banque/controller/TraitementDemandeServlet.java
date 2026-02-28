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
import com.banque.model.Utilisateur;
import org.json.JSONObject;

/**
 * Servlet pour traiter (valider/refuser) une demande de prêt.
 */
@WebServlet("/agent/traiter-demande")
public class TraitementDemandeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDemandePretDAO demandeDAO;

    public TraitementDemandeServlet() {
        this.demandeDAO = new DemandePretDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Vérification session agent
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (user == null || !"AGENT".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Non autorisé - Accès réservé aux agents\"}");
            return;
        }

        try {
            // 2. Récupération des paramètres
            String idStr = request.getParameter("idDemande");
            String action = request.getParameter("action"); // "VALIDE" ou "REJETE"

            if (idStr == null || action == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Paramètres manquants (idDemande, action)\"}");
                return;
            }

            int idDemande = Integer.parseInt(idStr);

            // 3. Validation de l'action
            String nouveauStatut;
            if ("VALIDE".equalsIgnoreCase(action)) {
                nouveauStatut = "VALIDE";
            } else if ("REJETE".equalsIgnoreCase(action) || "REFUSE".equalsIgnoreCase(action)) {
                nouveauStatut = "REJETE";
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Action invalide (attendu: VALIDE ou REJETE)\"}");
                return;
            }

            // 4. Exécution de la mise à jour
            demandeDAO.updateStatus(idDemande, nouveauStatut);

            System.out.println(
                    "✅ Demande #" + idDemande + " traitée par agent " + user.getNom() + " -> " + nouveauStatut);

            // 5. Réponse succès
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("idDemande", idDemande);
            jsonResponse.put("nouveauStatut", nouveauStatut);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(jsonResponse.toString());

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
