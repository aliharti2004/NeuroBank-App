package com.banque.controller;

import com.banque.dao.*;
import com.banque.model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/client/detail_pret")
public class DetailPretServlet extends HttpServlet {
    private IDemandePretDAO demandeDAO = new DemandePretDAOImpl();
    private IClientDAO clientDAO = new ClientDAOImpl();
    private IPredictionDAO predictionDAO = new PredictionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("../login.jsp");
            return;
        }

        // Récupérer l'ID de la demande
        String idDemandeStr = request.getParameter("id");
        if (idDemandeStr == null || idDemandeStr.isEmpty()) {
            response.sendRedirect("dashboard");
            return;
        }

        try {
            int idDemande = Integer.parseInt(idDemandeStr);
            System.out.println(">>> DetailPretServlet : Récupération demande ID=" + idDemande);

            // Récupérer la demande complète
            DemandePret demande = demandeDAO.findById(idDemande);
            System.out.println(">>> Demande trouvée : " + (demande != null));

            if (demande == null) {
                System.err.println(">>> ERREUR : Demande introuvable ID=" + idDemande);
                session.setAttribute("errorMsg", "Demande introuvable.");
                response.sendRedirect("dashboard");
                return;
            }

            // Vérifier que la demande appartient bien au client connecté
            Client client = clientDAO.findByUserId(user.getIdUser());
            System.out.println(">>> Client trouvé : " + (client != null));

            if (client == null || demande.getIdClient() != client.getIdClient()) {
                System.err.println(
                        ">>> ERREUR : Accès refusé - Client ID=" + (client != null ? client.getIdClient() : "null") +
                                ", Demande.idClient=" + demande.getIdClient());
                session.setAttribute("errorMsg", "Accès non autorisé.");
                response.sendRedirect("dashboard");
                return;
            }

            // Récupérer la prédiction IA si elle existe (TEMPORAIREMENT COMMENTÉ POUR
            // DEBUG)
            PredictionIA prediction = null;
            try {
                prediction = predictionDAO.findByDemandeId(idDemande);
                System.out.println(">>> Prédiction trouvée : " + (prediction != null));
            } catch (Exception e) {
                System.err.println(">>> AVERTISSEMENT : Erreur récupération prédiction (ignorée) : " + e.getMessage());
                // On continue sans la prédiction
            }

            // Passer les données à la JSP
            request.setAttribute("demande", demande);
            request.setAttribute("client", client);
            request.setAttribute("prediction", prediction);

            System.out.println(">>> Forward vers detail_pret.jsp");
            request.getRequestDispatcher("detail_pret.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println(">>> ERREUR : ID invalide - " + idDemandeStr);
            session.setAttribute("errorMsg", "ID de demande invalide.");
            response.sendRedirect("dashboard");
        } catch (Exception e) {
            System.err.println(">>> ERREUR CRITIQUE : " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMsg", "Erreur lors de la récupération des détails.");
            response.sendRedirect("dashboard");
        }
    }
}
