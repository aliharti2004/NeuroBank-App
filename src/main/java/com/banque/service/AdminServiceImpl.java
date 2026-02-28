package com.banque.service;

import com.banque.dao.IUtilisateurDAO;
import com.banque.dao.UtilisateurDAOImpl;
import com.banque.model.Utilisateur;

public class AdminServiceImpl implements IAdminService {
    private IUtilisateurDAO userDAO = new UtilisateurDAOImpl();

    @Override
    public void modifierEtatCompte(int idUser, boolean actif) {
        // Logique pour activer/désactiver un utilisateur
    }

    @Override
    public void creerAgent(Utilisateur agent) {
        agent.setRole("AGENT");
        userDAO.insert(agent);
    }
}