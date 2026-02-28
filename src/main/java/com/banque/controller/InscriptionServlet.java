package com.banque.controller;

import com.banque.service.ClientServiceImpl;
import com.banque.service.IClientService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/inscription")
public class InscriptionServlet extends HttpServlet {
    private IClientService clientService = new ClientServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("inscription.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            clientService.inscrireClientInitial(nom, prenom, email, password);
            request.setAttribute("success", "Inscription réussie !");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("inscription.jsp").forward(request, response);
        }
    }
}