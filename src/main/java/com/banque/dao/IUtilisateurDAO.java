package com.banque.dao;

import com.banque.model.Utilisateur;
import java.util.List;

public interface IUtilisateurDAO {
    Utilisateur findById(int id);

    List<Utilisateur> findAllAgents();

    List<Utilisateur> findAll(); // Get all users (for admin management)

    int insert(Utilisateur u);

    boolean update(Utilisateur u); // Update existing user

    boolean delete(int userId); // Delete user by ID

    Utilisateur findByLogin(String login);// Utile pour l'attribution auto

    int countByRole(String role);
}