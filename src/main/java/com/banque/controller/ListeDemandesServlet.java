package com.banque.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.dao.DemandePretDAOImpl;
import com.banque.dao.IDemandePretDAO;
import com.banque.dao.IPredictionDAO;
import com.banque.dao.PredictionDAOImpl;
import com.banque.model.DemandePret;
import com.banque.model.PredictionIA;
import com.banque.model.Utilisateur;

@WebServlet("/agent/demandes")
public class ListeDemandesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDemandePretDAO demandeDAO;

    public ListeDemandesServlet() {
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

        String paramStatut = request.getParameter("statut");
        // REMOVED: Default to EN_ATTENTE. Now default is null (show all)
        final String filtreStatut = paramStatut;

        String filtreType = request.getParameter("type");
        List<DemandePret> allDemandes = demandeDAO.findAll();

        // Apply status filter
        if (filtreStatut != null && !filtreStatut.isEmpty()) {
            allDemandes = allDemandes.stream()
                    .filter(d -> filtreStatut.equals(d.getStatut()))
                    .collect(Collectors.toList());
        }

        // Apply type filter
        if (filtreType != null && !filtreType.isEmpty()) {
            allDemandes = allDemandes.stream()
                    .filter(d -> filtreType.equals(d.getTypePret()))
                    .collect(Collectors.toList());
        }

        // === SORTING ===
        // Sort: EN_ATTENTE first, then by Date (Newest first)
        Collections.sort(allDemandes, (d1, d2) -> {
            boolean isPending1 = "EN_ATTENTE".equals(d1.getStatut());
            boolean isPending2 = "EN_ATTENTE".equals(d2.getStatut());

            if (isPending1 && !isPending2) {
                return -1; // d1 comes first
            } else if (!isPending1 && isPending2) {
                return 1; // d2 comes first
            } else {
                // Both are pending or both are processed -> Sort by Date Descending
                // Handle null dates gracefully (though creation date should not be null)
                if (d1.getDateCreation() == null)
                    return 1;
                if (d2.getDateCreation() == null)
                    return -1;
                return d2.getDateCreation().compareTo(d1.getDateCreation());
            }
        });

        // === PAGINATION ===
        int itemsPerPage = 10;
        int totalItems = allDemandes.size();
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

        List<DemandePret> demandes = (totalItems > 0) ? allDemandes.subList(startIndex, endIndex) : allDemandes;

        // ✨ NOUVEAU: Charger les prédictions IA pour chaque demande
        IPredictionDAO predictionDAO = new PredictionDAOImpl();
        Map<Integer, PredictionIA> predictions = new HashMap<>();

        for (DemandePret d : demandes) {
            PredictionIA pred = predictionDAO.findByDemandeId(d.getIdDemande());
            if (pred != null) {
                predictions.put(d.getIdDemande(), pred);
            }
        }

        // CRITICAL FIX: Change attribute name from "listeDemandes" to "demandes" to
        // match JSP
        request.setAttribute("demandes", demandes);
        request.setAttribute("predictions", predictions);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("filtreStatut", filtreStatut);
        request.setAttribute("filtreType", filtreType);

        request.getRequestDispatcher("/agent/demandes.jsp").forward(request, response);
    }
}
