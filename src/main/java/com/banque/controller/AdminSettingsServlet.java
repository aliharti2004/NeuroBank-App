package com.banque.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.dao.IUtilisateurDAO;
import com.banque.dao.UtilisateurDAOImpl;
import com.banque.model.Utilisateur;

@WebServlet("/admin/settings")
public class AdminSettingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUtilisateurDAO utilisateurDAO;

    public AdminSettingsServlet() {
        this.utilisateurDAO = new UtilisateurDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateur");

        // Security check
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get fresh user data from database
        Utilisateur admin = utilisateurDAO.findById(currentUser.getIdUser());

        // System information
        Runtime runtime = Runtime.getRuntime();
        long totalMemoryMB = runtime.totalMemory() / (1024 * 1024);
        long freeMemoryMB = runtime.freeMemory() / (1024 * 1024);
        long usedMemoryMB = totalMemoryMB - freeMemoryMB;
        int memoryUsagePercent = (int) ((usedMemoryMB * 100) / totalMemoryMB);

        request.setAttribute("admin", admin);
        request.setAttribute("totalMemoryMB", totalMemoryMB);
        request.setAttribute("usedMemoryMB", usedMemoryMB);
        request.setAttribute("memoryUsagePercent", memoryUsagePercent);
        request.setAttribute("javaVersion", System.getProperty("java.version"));
        request.setAttribute("osName", System.getProperty("os.name"));

        request.getRequestDispatcher("/admin/admin_settings.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateur");

        // Security check
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            handleUpdateProfile(request, response, session, currentUser);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response, session, currentUser);
        }

        response.sendRedirect(request.getContextPath() + "/admin/settings");
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, Utilisateur currentUser) {
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String login = request.getParameter("login");

        // Validation
        if (prenom == null || nom == null || login == null ||
                prenom.trim().isEmpty() || nom.trim().isEmpty() || login.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Tous les champs sont obligatoires");
            return;
        }

        // Check if email is already used by another user
        Utilisateur existingUser = utilisateurDAO.findByLogin(login);
        if (existingUser != null && existingUser.getIdUser() != currentUser.getIdUser()) {
            session.setAttribute("errorMsg", "Cet email est déjà utilisé par un autre utilisateur");
            return;
        }

        // Get current user data
        Utilisateur admin = utilisateurDAO.findById(currentUser.getIdUser());
        if (admin == null) {
            session.setAttribute("errorMsg", "Utilisateur introuvable");
            return;
        }

        // Update profile
        admin.setPrenom(prenom);
        admin.setNom(nom);
        admin.setLogin(login);
        admin.setMotDePasse(null); // Don't update password here

        if (utilisateurDAO.update(admin)) {
            // Update session
            currentUser.setPrenom(prenom);
            currentUser.setNom(nom);
            currentUser.setLogin(login);
            session.setAttribute("utilisateur", currentUser);
            session.setAttribute("successMsg", "Profil mis à jour avec succès");
        } else {
            session.setAttribute("errorMsg", "Erreur lors de la mise à jour du profil");
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, Utilisateur currentUser) {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        if (currentPassword == null || newPassword == null || confirmPassword == null ||
                currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Tous les champs de mot de passe sont obligatoires");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("errorMsg", "Les nouveaux mots de passe ne correspondent pas");
            return;
        }

        if (newPassword.length() < 6) {
            session.setAttribute("errorMsg", "Le mot de passe doit contenir au moins 6 caractères");
            return;
        }

        // Get current user data
        Utilisateur admin = utilisateurDAO.findById(currentUser.getIdUser());
        if (admin == null) {
            session.setAttribute("errorMsg", "Utilisateur introuvable");
            return;
        }

        // Verify current password (in production, you should hash passwords)
        if (!admin.getMotDePasse().equals(currentPassword)) {
            session.setAttribute("errorMsg", "Le mot de passe actuel est incorrect");
            return;
        }

        // Update password
        admin.setMotDePasse(newPassword); // In production, hash this!
        admin.setPrenom(null); // Signal to update only password
        admin.setNom(null);
        admin.setLogin(null);

        if (utilisateurDAO.update(admin)) {
            session.setAttribute("successMsg", "Mot de passe modifié avec succès");
        } else {
            session.setAttribute("errorMsg", "Erreur lors de la modification du mot de passe");
        }
    }
}
