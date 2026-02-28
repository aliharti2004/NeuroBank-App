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

import com.banque.dao.DemandePretDAOImpl;
import com.banque.dao.IDemandePretDAO;
import com.banque.model.DemandePret;
import com.banque.model.Utilisateur;

@WebServlet("/agent/historique")
public class HistoriqueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDemandePretDAO demandeDAO;

    public HistoriqueServlet() {
        this.demandeDAO = new DemandePretDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user == null || !"AGENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer toutes les demandes
        List<DemandePret> allDemandes = demandeDAO.findAll();

        // Filtrer pour ne garder que les demandes terminées (VALIDE ou REJETE)
        List<DemandePret> historique = allDemandes.stream()
                .filter(d -> "VALIDE".equals(d.getStatut()) || "REJETE".equals(d.getStatut()))
                .collect(Collectors.toList());

        // === FILTRAGE ===
        String filtreStatut = request.getParameter("statut");
        if (filtreStatut != null && !filtreStatut.isEmpty()) {
            historique = historique.stream()
                    .filter(d -> filtreStatut.equals(d.getStatut()))
                    .collect(Collectors.toList());
        }

        String filtreType = request.getParameter("type");
        if (filtreType != null && !filtreType.isEmpty()) {
            historique = historique.stream()
                    .filter(d -> filtreType.equals(d.getTypePret()))
                    .collect(Collectors.toList());
        }

        // Calculate statistics (on filtered or full history? Usually full history for
        // stats cards)
        // Let's keep stats based on FULL history for the top cards
        long totalTraitees = allDemandes.stream()
                .filter(d -> "VALIDE".equals(d.getStatut()) || "REJETE".equals(d.getStatut()))
                .count();
        long totalValidees = allDemandes.stream()
                .filter(d -> "VALIDE".equals(d.getStatut()))
                .count();
        long totalRejetees = allDemandes.stream()
                .filter(d -> "REJETE".equals(d.getStatut()))
                .count();

        // === PAGINATION ===
        int itemsPerPage = 10;
        int totalItems = historique.size();
        int totalPages = (totalItems > 0) ? (int) Math.ceil((double) totalItems / itemsPerPage) : 1;

        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > totalPages)
                    currentPage = totalPages;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int startIndex = (currentPage - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

        List<DemandePret> pageHistorique = (totalItems > 0) ? historique.subList(startIndex, endIndex) : historique;

        // CRITICAL FIX: Change attribute name from "listeHistorique" to "historique" to
        // match JSP
        request.setAttribute("historique", pageHistorique);
        request.setAttribute("totalTraitees", totalTraitees);
        request.setAttribute("totalValidees", totalValidees);
        request.setAttribute("totalRejetees", totalRejetees);

        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("filtreStatut", filtreStatut);
        request.setAttribute("filtreType", filtreType);

        request.getRequestDispatcher("/agent/historique.jsp").forward(request, response);
    }
}
