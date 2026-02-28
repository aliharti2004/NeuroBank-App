package com.banque.service;

import com.banque.dao.*;
import com.banque.model.*;

public class ClientServiceImpl implements IClientService {
    private IUtilisateurDAO userDAO = new UtilisateurDAOImpl();
    private IClientDAO clientDAO = new ClientDAOImpl();

    @Override
    public void inscrireClientInitial(String nom, String prenom, String email, String password) {
        Utilisateur u = new Utilisateur();
        u.setLogin(email);
        u.setMotDePasse(password);
        u.setNom(nom);
        u.setPrenom(prenom);
        u.setRole("CLIENT");
        u.setActif(true);

        // Cette ligne compile maintenant parfaitement
        int idGenere = userDAO.insert(u); 

        if (idGenere != -1) {
            // Création obligatoire de la ligne dans T_CLIENT
            Client c = new Client();
            c.setIdUser(idGenere);
            clientDAO.creerProfilVide(c); 
        }
    }

    @Override
    public void completerProfilFinancier(Client c) {
        clientDAO.updateFinancials(c); // Effectue l'UPDATE
    }
}

