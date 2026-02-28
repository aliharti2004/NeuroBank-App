package com.banque.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet qui gère la page d'accueil (root)
 * Redirige vers la landing page si non authentifié
 * Redirige vers le dashboard approprié si déjà connecté
 */
@WebServlet("/")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Si l'utilisateur est déjà connecté, rediriger vers son dashboard
        if (session != null && session.getAttribute("user") != null) {
            com.banque.model.Utilisateur user = (com.banque.model.Utilisateur) session.getAttribute("user");

            String role = user.getRole();

            switch (role) {
                case "CLIENT":
                    response.sendRedirect(request.getContextPath() + "/client/dashboard");
                    break;
                case "AGENT":
                    response.sendRedirect(request.getContextPath() + "/agent/dashboard");
                    break;
                case "ADMIN":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
                default:
                    // Si rôle inconnu, afficher la landing page
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } else {
            // Pas de session active, afficher la landing page
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
