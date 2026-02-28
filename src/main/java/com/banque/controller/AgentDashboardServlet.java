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

@WebServlet("/agent/dashboard")
public class AgentDashboardServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;
        private IDemandePretDAO demandeDAO;

        public AgentDashboardServlet() {
                this.demandeDAO = new DemandePretDAOImpl();
        }

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                // Vérification session agent
                HttpSession session = request.getSession();
                Utilisateur user = (Utilisateur) session.getAttribute("user");

                if (user == null || !"AGENT".equals(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/login.jsp");
                        return;
                }

                // Récupération de toutes les demandes
                List<DemandePret> allDemandes = demandeDAO.findAll();

                // Calcul des statistiques
                long enAttente = allDemandes.stream()
                                .filter(d -> "EN_ATTENTE".equals(d.getStatut()))
                                .count();

                long totalTraitees = allDemandes.stream()
                                .filter(d -> !"EN_ATTENTE".equals(d.getStatut()))
                                .count();

                long validees = allDemandes.stream()
                                .filter(d -> "VALIDE".equals(d.getStatut()))
                                .count();

                long rejetees = allDemandes.stream()
                                .filter(d -> "REJETE".equals(d.getStatut()))
                                .count();

                double tauxApprobation = totalTraitees > 0 ? (double) validees / totalTraitees * 100 : 0.0;

                // Calcul des montants
                double montantEnAttente = allDemandes.stream()
                                .filter(d -> "EN_ATTENTE".equals(d.getStatut()))
                                .mapToDouble(d -> d.getMontantPret().doubleValue())
                                .sum();

                double montantAccorde = allDemandes.stream()
                                .filter(d -> "VALIDE".equals(d.getStatut()))
                                .mapToDouble(d -> d.getMontantPret().doubleValue())
                                .sum();

                // Stats par type
                long countImmo = allDemandes.stream()
                                .filter(d -> "immobilier".equalsIgnoreCase(d.getTypePret()))
                                .count();

                long countAuto = allDemandes.stream()
                                .filter(d -> "automobile".equalsIgnoreCase(d.getTypePret()))
                                .count();

                // Passer les données à la JSP
                request.setAttribute("statEnAttente", enAttente);
                request.setAttribute("statTraitees", totalTraitees);
                request.setAttribute("statValidees", validees);
                request.setAttribute("statRejetees", rejetees);
                request.setAttribute("statTauxApprobation", Math.round(tauxApprobation));

                request.setAttribute("montantEnAttente", montantEnAttente);
                request.setAttribute("montantAccorde", montantAccorde);

                request.setAttribute("countImmo", countImmo);
                request.setAttribute("countAuto", countAuto);

                request.getRequestDispatcher("/agent/agent_dashboard.jsp").forward(request, response);
        }
}
