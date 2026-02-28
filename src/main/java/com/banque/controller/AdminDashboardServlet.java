package com.banque.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.utils.DBConnection;
import com.banque.dao.DemandePretDAOImpl;
import com.banque.dao.IDemandePretDAO;
import com.banque.dao.IUtilisateurDAO;
import com.banque.dao.UtilisateurDAOImpl;
import com.banque.model.DemandePret;
import com.banque.model.Utilisateur;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUtilisateurDAO utilisateurDAO;
    private IDemandePretDAO demandeDAO;

    public AdminDashboardServlet() {
        this.utilisateurDAO = new UtilisateurDAOImpl();
        this.demandeDAO = new DemandePretDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 1. Global Statistics
        int totalClients = utilisateurDAO.countByRole("CLIENT");
        int totalAgents = utilisateurDAO.countByRole("AGENT");

        List<DemandePret> allDemandes = demandeDAO.findAll();
        int totalDemandes = allDemandes.size();

        double totalVolumeAccorde = allDemandes.stream()
                .filter(d -> "VALIDE".equals(d.getStatut()))
                .map(DemandePret::getMontantPret)
                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add)
                .doubleValue();

        // --- NEW KPIs ---
        long countValide = allDemandes.stream().filter(d -> "VALIDE".equals(d.getStatut())).count();
        long countRejete = allDemandes.stream().filter(d -> "REJETE".equals(d.getStatut())).count();
        long countEnAttente = allDemandes.stream().filter(d -> "EN_ATTENTE".equals(d.getStatut())).count();
        long countTraite = countValide + countRejete;

        // Taux d'approbation
        double approvalRate = (countTraite > 0) ? ((double) countValide / countTraite) * 100 : 0;

        // Montant moyen accordé
        double avgLoanAmount = (countValide > 0) ? totalVolumeAccorde / countValide : 0;

        // Temps moyen de traitement (en jours)
        double avgProcessingTime = allDemandes.stream()
                .filter(d -> ("VALIDE".equals(d.getStatut()) || "REJETE".equals(d.getStatut()))
                        && d.getDateDecision() != null && d.getDateCreation() != null)
                .mapToLong(d -> d.getDateDecision().getTime() - d.getDateCreation().getTime())
                .average()
                .orElse(0);
        // Convert ms to days
        avgProcessingTime = avgProcessingTime / (1000 * 60 * 60 * 24);

        // --- CHART DATA ---
        // Status Distribution
        request.setAttribute("chartPending", countEnAttente);
        request.setAttribute("chartValidated", countValide);
        request.setAttribute("chartRejected", countRejete);

        // Loan Type Distribution (matching database values: lowercase)
        // Debug: Print all unique loan types
        System.out.println("=== DEBUG: Loan Type Analysis ===");
        allDemandes.forEach(d -> System.out.println("TypePret: '" + d.getTypePret() + "'"));

        long countImmo = allDemandes.stream()
                .filter(d -> d.getTypePret() != null && d.getTypePret().equalsIgnoreCase("immobilier"))
                .count();
        long countAuto = allDemandes.stream()
                .filter(d -> d.getTypePret() != null && d.getTypePret().equalsIgnoreCase("automobile"))
                .count();

        System.out.println("Count Immobilier: " + countImmo);
        System.out.println("Count Automobile: " + countAuto);
        System.out.println("================================");

        request.setAttribute("chartImmo", countImmo);
        request.setAttribute("chartAuto", countAuto);

        // 2. System Health
        boolean dbStatus = checkDatabaseConnection();
        long totalMemory = Runtime.getRuntime().totalMemory();
        long freeMemory = Runtime.getRuntime().freeMemory();
        long usedMemory = totalMemory - freeMemory;
        long maxMemory = Runtime.getRuntime().maxMemory();

        // Convert to MB
        long usedMemoryMB = usedMemory / (1024 * 1024);
        long totalMemoryMB = totalMemory / (1024 * 1024);
        long maxMemoryMB = maxMemory / (1024 * 1024);

        // Calculate percentage
        int memoryUsagePercent = (int) ((double) usedMemory / totalMemory * 100);

        // Set attributes
        request.setAttribute("totalClients", totalClients);
        request.setAttribute("totalAgents", totalAgents);
        request.setAttribute("totalDemandes", totalDemandes);
        request.setAttribute("totalVolumeAccorde", totalVolumeAccorde);

        request.setAttribute("approvalRate", Math.round(approvalRate * 10.0) / 10.0); // 1 decimal
        request.setAttribute("avgLoanAmount", Math.round(avgLoanAmount));
        request.setAttribute("avgProcessingTime", Math.round(avgProcessingTime * 10.0) / 10.0); // 1 decimal

        request.setAttribute("dbStatus", dbStatus);
        request.setAttribute("usedMemoryMB", usedMemoryMB);
        request.setAttribute("totalMemoryMB", totalMemoryMB);
        request.setAttribute("memoryUsagePercent", memoryUsagePercent);
        request.setAttribute("activeTab", "dashboard");

        request.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(request, response);
    }

    private boolean checkDatabaseConnection() {
        try (Connection conn = DBConnection.getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            return false;
        }
    }
}
