package com.banque.service;
import com.banque.model.Utilisateur;
import java.util.List;

public interface IAdminService {
    void modifierEtatCompte(int idUser, boolean actif);
    void creerAgent(Utilisateur agent);
}