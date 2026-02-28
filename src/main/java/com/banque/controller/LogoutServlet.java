package com.banque.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet de déconnexion.
 * Invalide la session courante et redirige vers la page de login.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupération de la session (sans en créer une nouvelle)
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidation de la session
            session.invalidate();
        }

        // Redirection vers la page de login avec un message
        response.sendRedirect(request.getContextPath() + "/login.jsp?logout=success");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
