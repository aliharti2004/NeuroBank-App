package com.banque.controller;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.dao.ClientDAOImpl;
import com.banque.dao.IClientDAO;
import com.banque.model.Client;
import com.banque.model.Utilisateur;

@WebServlet("/client/complete-profile")
public class CompleteProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IClientDAO clientDAO;

    public CompleteProfileServlet() {
        this.clientDAO = new ClientDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        // Security check
        if (user == null || !"CLIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Forward to the profile completion page
        request.getRequestDispatcher("/client/complete_profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        // Security check
        if (user == null || !"CLIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get form parameters
        String ville = request.getParameter("ville");
        String codePostal = request.getParameter("codePostal");
        String revenuStr = request.getParameter("revenu");

        // Validation
        if (ville == null || ville.trim().isEmpty() ||
                codePostal == null || codePostal.trim().isEmpty() ||
                revenuStr == null || revenuStr.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Tous les champs sont obligatoires");
            response.sendRedirect(request.getContextPath() + "/client/complete-profile");
            return;
        }

        try {
            BigDecimal revenu = new BigDecimal(revenuStr);

            if (revenu.compareTo(BigDecimal.ZERO) <= 0) {
                session.setAttribute("errorMsg", "Le revenu doit être supérieur à 0");
                response.sendRedirect(request.getContextPath() + "/client/complete-profile");
                return;
            }

            // Create or update client profile
            Client client = clientDAO.findByUserId(user.getIdUser());

            if (client == null) {
                // Create new client profile
                client = new Client();
                client.setIdUser(user.getIdUser());
                client.setVille(ville);
                client.setCodePostal(codePostal);
                client.setRevenuMensuel(revenu);

                Client insertedClient = clientDAO.insert(client);
                if (insertedClient != null && insertedClient.getIdClient() > 0) {
                    session.setAttribute("successMsg", "Profil complété avec succès!");
                    // Redirect to new loan request page
                    response.sendRedirect(request.getContextPath() + "/client/nouveau_pret");
                } else {
                    session.setAttribute("errorMsg", "Erreur lors de la création du profil");
                    response.sendRedirect(request.getContextPath() + "/client/complete-profile");
                }
            } else {
                // Update existing client profile
                client.setVille(ville);
                client.setCodePostal(codePostal);
                client.setRevenuMensuel(revenu);

                try {
                    clientDAO.updateFinancials(client);
                    session.setAttribute("successMsg", "Profil mis à jour avec succès!");
                    response.sendRedirect(request.getContextPath() + "/client/nouveau_pret");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Erreur lors de la mise à jour du profil");
                    response.sendRedirect(request.getContextPath() + "/client/complete-profile");
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Le revenu doit être un nombre valide");
            response.sendRedirect(request.getContextPath() + "/client/complete-profile");
        }
    }
}
