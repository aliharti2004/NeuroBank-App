package com.banque.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.dao.IUtilisateurDAO;
import com.banque.dao.UtilisateurDAOImpl;
import com.banque.model.Utilisateur;

@WebServlet("/admin/users")
public class ManageUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int ITEMS_PER_PAGE = 10;
    private IUtilisateurDAO utilisateurDAO;

    public ManageUsersServlet() {
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

        // Get all users
        List<Utilisateur> allUsers = utilisateurDAO.findAll();
        List<Utilisateur> filteredUsers = allUsers;

        // Get filter parameters
        String roleFilter = request.getParameter("role");
        String statusFilter = request.getParameter("status");
        String searchTerm = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "date"; // Default sort
        }

        // Apply role filter
        if (roleFilter != null && !roleFilter.isEmpty() && !"ALL".equals(roleFilter)) {
            filteredUsers = filteredUsers.stream()
                    .filter(u -> roleFilter.equals(u.getRole()))
                    .collect(Collectors.toList());
        }

        // Apply status filter
        if (statusFilter != null && !statusFilter.isEmpty() && !"ALL".equals(statusFilter)) {
            boolean isActive = "ACTIVE".equals(statusFilter);
            filteredUsers = filteredUsers.stream()
                    .filter(u -> u.isActif() == isActive)
                    .collect(Collectors.toList());
        }

        // Apply search filter
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            String searchLower = searchTerm.toLowerCase();
            filteredUsers = filteredUsers.stream()
                    .filter(u -> u.getNom().toLowerCase().contains(searchLower)
                            || u.getPrenom().toLowerCase().contains(searchLower)
                            || u.getLogin().toLowerCase().contains(searchLower))
                    .collect(Collectors.toList());
        }

        // Apply sorting
        if ("name".equals(sortBy)) {
            filteredUsers.sort((u1, u2) -> u1.getNom().compareTo(u2.getNom()));
        } else if ("email".equals(sortBy)) {
            filteredUsers.sort((u1, u2) -> u1.getLogin().compareTo(u2.getLogin()));
        } else if ("role".equals(sortBy)) {
            filteredUsers.sort((u1, u2) -> u1.getRole().compareTo(u2.getRole()));
        } else { // date
            filteredUsers.sort((u1, u2) -> u2.getDateCreation().compareTo(u1.getDateCreation()));
        }

        // Pagination
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int totalUsers = filteredUsers.size();
        int totalPages = (int) Math.ceil((double) totalUsers / ITEMS_PER_PAGE);
        if (currentPage < 1)
            currentPage = 1;
        if (currentPage > totalPages && totalPages > 0)
            currentPage = totalPages;

        int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalUsers);

        List<Utilisateur> paginatedUsers = filteredUsers.subList(startIndex, endIndex);

        // Set attributes
        request.setAttribute("users", paginatedUsers);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("itemsPerPage", ITEMS_PER_PAGE);

        request.setAttribute("roleFilter", roleFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("activeTab", "users");

        request.getRequestDispatcher("/admin/manage_users.jsp").forward(request, response);
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

        if ("create".equals(action)) {
            handleCreateUser(request, response, session);
        } else if ("edit".equals(action)) {
            handleEditUser(request, response, session);
        } else if ("delete".equals(action)) {
            handleDeleteUser(request, response, session, currentUser);
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String role = request.getParameter("role");

        // Validation
        if (login == null || password == null || nom == null || prenom == null || role == null
                || login.trim().isEmpty() || password.trim().isEmpty() || nom.trim().isEmpty()
                || prenom.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Tous les champs sont obligatoires");
            return;
        }

        // Check if login already exists
        if (utilisateurDAO.findByLogin(login) != null) {
            session.setAttribute("errorMsg", "Cet email est déjà utilisé");
            return;
        }

        Utilisateur newUser = new Utilisateur();
        newUser.setLogin(login);
        newUser.setMotDePasse(password); // In production, hash this password!
        newUser.setNom(nom);
        newUser.setPrenom(prenom);
        newUser.setRole(role);
        newUser.setActif(true);

        int userId = utilisateurDAO.insert(newUser);
        if (userId > 0) {
            session.setAttribute("successMsg", "Utilisateur créé avec succès");
        } else {
            session.setAttribute("errorMsg", "Erreur lors de la création de l'utilisateur");
        }
    }

    private void handleEditUser(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        String userIdStr = request.getParameter("userId");
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String role = request.getParameter("role");
        String actifStr = request.getParameter("actif");

        // Validation
        if (userIdStr == null || login == null || nom == null || prenom == null || role == null) {
            session.setAttribute("errorMsg", "Données invalides");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            Utilisateur user = utilisateurDAO.findById(userId);

            if (user == null) {
                session.setAttribute("errorMsg", "Utilisateur introuvable");
                return;
            }

            user.setLogin(login);
            // Only update password if provided
            if (password != null && !password.trim().isEmpty()) {
                user.setMotDePasse(password); // In production, hash this!
            } else {
                user.setMotDePasse(null); // Don't update password
            }
            user.setNom(nom);
            user.setPrenom(prenom);
            user.setRole(role);
            user.setActif("true".equals(actifStr));

            if (utilisateurDAO.update(user)) {
                session.setAttribute("successMsg", "Utilisateur modifié avec succès");
            } else {
                session.setAttribute("errorMsg", "Erreur lors de la modification");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "ID utilisateur invalide");
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session,
            Utilisateur currentUser) {
        String userIdStr = request.getParameter("userId");

        if (userIdStr == null) {
            session.setAttribute("errorMsg", "ID utilisateur manquant");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);

            // Prevent self-deletion
            if (userId == currentUser.getIdUser()) {
                session.setAttribute("errorMsg", "Vous ne pouvez pas vous supprimer vous-même");
                return;
            }

            if (utilisateurDAO.delete(userId)) {
                session.setAttribute("successMsg", "Utilisateur supprimé avec succès");
            } else {
                session.setAttribute("errorMsg", "Erreur lors de la suppression");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "ID utilisateur invalide");
        }
    }
}
