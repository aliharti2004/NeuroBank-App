package com.banque.controller;

import com.banque.model.*;
import com.banque.dao.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/client/dashboard")
public class ClientDashboardServlet extends HttpServlet {
    private IClientDAO clientDAO = new ClientDAOImpl();
    private IDemandePretDAO demandeDAO = new DemandePretDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user != null) {
            // 1. Profil client
            Client info = clientDAO.findByUserId(user.getIdUser());
            request.setAttribute("client", info);

            // 2. Demandes du client
            if (info != null) {
                List<DemandePret> demandes = demandeDAO.findByClientId(info.getIdClient());
                request.setAttribute("demandes", demandes);

                // 3. Calcul statistiques pour cartes dashboard
                int totalDemandes = demandes.size();
                int enAttente = 0;
                int validees = 0;
                int rejetees = 0;
                double montantTotal = 0.0;

                for (DemandePret d : demandes) {
                    montantTotal += d.getMontantPret().doubleValue();
                    String statut = d.getStatut();
                    if ("EN_ATTENTE".equals(statut))
                        enAttente++;
                    else if ("VALIDE".equals(statut))
                        validees++;
                    else if ("REJETE".equals(statut))
                        rejetees++;
                }

                request.setAttribute("totalDemandes", totalDemandes);
                request.setAttribute("enAttente", enAttente);
                request.setAttribute("validees", validees);
                request.setAttribute("rejetees", rejetees);
                request.setAttribute("montantTotal", montantTotal);
            } else {
                // Client sans profil : stats à 0
                request.setAttribute("totalDemandes", 0);
                request.setAttribute("montantTotal", 0.0);
            }

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("../login.jsp");
        }
    }
}