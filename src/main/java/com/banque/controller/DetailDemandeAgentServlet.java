package com.banque.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.dao.ClientDAOImpl;
import com.banque.dao.DemandePretDAOImpl;
import com.banque.dao.IClientDAO;
import com.banque.dao.IDemandePretDAO;
import com.banque.dao.IPredictionDAO;
import com.banque.dao.IUtilisateurDAO;
import com.banque.dao.PredictionDAOImpl;
import com.banque.dao.UtilisateurDAOImpl;
import com.banque.model.Client;
import com.banque.model.DemandePret;
import com.banque.model.PredictionIA;
import com.banque.model.Utilisateur;

@WebServlet("/agent/details")
public class DetailDemandeAgentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDemandePretDAO demandeDAO;
    private IClientDAO clientDAO;
    private IPredictionDAO predictionDAO;
    private IUtilisateurDAO utilisateurDAO;

    public DetailDemandeAgentServlet() {
        this.demandeDAO = new DemandePretDAOImpl();
        this.clientDAO = new ClientDAOImpl();
        this.predictionDAO = new PredictionDAOImpl();
        this.utilisateurDAO = new UtilisateurDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user == null || !"AGENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/agent/demandes");
            return;
        }

        int idDemande = Integer.parseInt(idParam);
        DemandePret demande = demandeDAO.findById(idDemande);

        if (demande == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Demande non trouvée");
            return;
        }

        // Récupérer le client
        Client client = clientDAO.findById(demande.getIdClient());

        // Récupérer l'utilisateur correspondant au client pour avoir nom et prénom
        Utilisateur clientUser = null;
        if (client != null) {
            clientUser = utilisateurDAO.findById(client.getIdUser());
        }

        // Récupérer la prédiction IA
        PredictionIA prediction = predictionDAO.findByDemandeId(idDemande);

        request.setAttribute("demande", demande);
        request.setAttribute("clientInfo", client);
        request.setAttribute("clientUser", clientUser);
        request.setAttribute("prediction", prediction);

        request.getRequestDispatcher("/agent/detail_demande.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur agent = (Utilisateur) session.getAttribute("user");

        if (agent == null || !"AGENT".equals(agent.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int idDemande = Integer.parseInt(request.getParameter("id_demande"));
        String action = request.getParameter("action");
        String nouveauStatut = "EN_ATTENTE";

        if ("approuver".equals(action)) {
            nouveauStatut = "VALIDE";
        } else if ("rejeter".equals(action)) {
            nouveauStatut = "REJETE";
        }

        // Mettre à jour le statut
        demandeDAO.updateStatus(idDemande, nouveauStatut);

        // Assigner l'agent qui a traité
        // NOTE: On suppose que Utilisateur.getId() correspond à un id_agent ou id_user
        // utilisé dans t_demande_pret.
        // En regardant le modèle, id_agent dans t_demande_pret est un entier.
        // On va utiliser id_utilisateur de la session.
        demandeDAO.assignAgent(idDemande, agent.getIdUser());

        response.sendRedirect(request.getContextPath() + "/agent/dashboard");
    }
}
