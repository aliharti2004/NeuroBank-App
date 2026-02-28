package com.banque.controller;

import com.banque.model.Utilisateur;
import com.banque.service.AuthServiceImpl;
import com.banque.service.IAuthService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IAuthService authService = new AuthServiceImpl();

    // Affiche la page de login (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("DEBUG: LoginServlet doGet entered");
        try {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            System.out.println("DEBUG: Forwarded to /login.jsp");
        } catch (Exception e) {
            System.err.println("DEBUG: Error forwarding to login.jsp");
            e.printStackTrace();
        }
    }

    @Override
    // Traite la connexion (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");
        String pass = request.getParameter("password");

        Utilisateur user = authService.login(login, pass);

        if (user != null) {
            // Création de la session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            // Pour compatibilité avec le code existant qui utilise peut-être "utilisateur"
            session.setAttribute("utilisateur", user);

            // Redirection selon le rôle
            if ("CLIENT".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/client/dashboard");
            } else if ("AGENT".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/agent/dashboard");
            } else if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                // Rôle inconnu
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            // Retour au formulaire avec un message clair
            request.setAttribute("error", "Identifiants invalides ou compte désactivé.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}