package com.banque.service;

import com.banque.dao.IUtilisateurDAO;
import com.banque.dao.UtilisateurDAOImpl;
import com.banque.model.Utilisateur;

public class AuthServiceImpl implements IAuthService {
    private IUtilisateurDAO userDAO = new UtilisateurDAOImpl();

    @Override
    public Utilisateur login(String login, String password) {
        Utilisateur user = userDAO.findByLogin(login);

        // Validation stricte : l'utilisateur existe, le MDP correspond et le compte est actif
        if (user != null && user.getMotDePasse().equals(password) && user.isActif()) {
            System.out.println("Connexion réussie pour : " + user.getLogin());
            return user;
        }
        
        System.out.println("Échec de connexion : Login ou MDP incorrect pour " + login);
        return null;
    }
}