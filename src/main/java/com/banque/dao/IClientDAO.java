package com.banque.dao;

import com.banque.model.Client;

public interface IClientDAO {
    Client insert(Client client);
    Client findById(int idClient);
    Client findByUserId(int idUser); // Pour charger le profil après authentification
    void updateFinancials(Client client); // Pour modifier revenu/ville avant une demande
	void creerProfilVide(Client c);
}