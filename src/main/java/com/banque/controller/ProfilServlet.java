package com.banque.controller;

import com.banque.model.Client;
import com.banque.model.Utilisateur;
import com.banque.dao.IClientDAO; // IMPORT MANQUANT
import com.banque.dao.ClientDAOImpl; // IMPORT MANQUANT
import com.banque.service.IClientService;
import com.banque.service.ClientServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/client/profil")
public class ProfilServlet extends HttpServlet {
    private IClientService clientService = new ClientServiceImpl();
    private IClientDAO clientDAO = new ClientDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user != null) {
            Client c = clientDAO.findByUserId(user.getIdUser());
            request.setAttribute("client", c);
            request.getRequestDispatcher("profil.jsp").forward(request, response);
        } else {
            response.sendRedirect("../login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user != null) {
            try {
                String ville = request.getParameter("ville");
                String codePostal = request.getParameter("cp");
                String revenuStr = request.getParameter("revenu");

                // Validation basique
                if (ville == null || ville.trim().isEmpty() ||
                        codePostal == null || codePostal.trim().isEmpty() ||
                        revenuStr == null || revenuStr.trim().isEmpty()) {
                    session.setAttribute("errorMsg", "Tous les champs sont obligatoires.");
                    response.sendRedirect("profil");
                    return;
                }

                Client c = new Client();
                c.setIdUser(user.getIdUser());
                c.setVille(ville.trim());
                c.setCodePostal(codePostal.trim());
                c.setRevenuMensuel(new BigDecimal(revenuStr));

                clientService.completerProfilFinancier(c);

                session.setAttribute("successMsg", "Profil mis à jour avec succès !");
                response.sendRedirect("dashboard");
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Le revenu doit être un nombre valide.");
                response.sendRedirect("profil");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMsg", "Erreur lors de la mise à jour du profil.");
                response.sendRedirect("profil");
            }
        } else {
            response.sendRedirect("../login.jsp");
        }
    }
}