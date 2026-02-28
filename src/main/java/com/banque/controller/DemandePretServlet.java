package com.banque.controller;

import com.banque.model.*;
import com.banque.service.*;
import com.banque.dao.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/client/nouveau_pret")
public class DemandePretServlet extends HttpServlet {
    private IPretService pretService = new PretServiceImpl();
    private IClientDAO clientDAO = new ClientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        // Security check
        if (user == null || !"CLIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check if profile is complete
        Client client = clientDAO.findByUserId(user.getIdUser());
        if (client == null || client.getVille() == null || client.getCodePostal() == null
                || client.getRevenuMensuel() == null || client.getRevenuMensuel().compareTo(BigDecimal.ZERO) <= 0) {
            // Profile incomplete, redirect to complete profile page
            response.sendRedirect(request.getContextPath() + "/client/complete-profile");
            return;
        }

        // Profile complete, show loan request form
        request.getRequestDispatcher("nouveau_pret.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user != null && "CLIENT".equals(user.getRole())) {
            try {
                // 1. Vérifier que le profil est complet
                Client client = clientDAO.findByUserId(user.getIdUser());

                if (client == null || client.getVille() == null || client.getCodePostal() == null
                        || client.getRevenuMensuel() == null
                        || client.getRevenuMensuel().compareTo(BigDecimal.ZERO) <= 0) {
                    session.setAttribute("errorMsg", "Veuillez compléter votre profil avant de demander un prêt.");
                    response.sendRedirect(request.getContextPath() + "/client/complete-profile");
                    return;
                }

                // 2. Construction de l'objet DemandePret
                DemandePret d = new DemandePret();
                d.setIdClient(client.getIdClient());
                d.setTypePret(request.getParameter("typePret"));
                d.setMontantPret(new BigDecimal(request.getParameter("montant")));
                d.setDureeMois(Integer.parseInt(request.getParameter("duree")));
                d.setTauxInteret(new BigDecimal(request.getParameter("taux")));

                // 3. Soumission (Calcul mensualité + IA + Assignation)
                pretService.soumettreNouvelleDemande(d);

                session.setAttribute("successMsg", "Demande de prêt soumise avec succès ! Un agent va l'examiner.");
                response.sendRedirect("dashboard");

            } catch (IllegalArgumentException e) {
                // Erreur règle 40%
                session.setAttribute("errorMsg", e.getMessage());
                response.sendRedirect("nouveau_pret");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMsg", "Erreur lors de la soumission : " + e.getMessage());
                response.sendRedirect("nouveau_pret");
            }
        } else {
            response.sendRedirect("../login.jsp");
        }
    }
}