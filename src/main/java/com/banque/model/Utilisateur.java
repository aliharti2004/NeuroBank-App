package com.banque.model;

import java.sql.Timestamp;

public class Utilisateur {
    private int idUser;
    private String login;
    private String motDePasse;
    private String role;
    private String nom;
    private String prenom;
    private Timestamp dateCreation;
    private boolean actif;

    public Utilisateur() {}

    public int getIdUser() { return idUser; }
    public void setIdUser(int idUser) { this.idUser = idUser; }
    public String getLogin() { return login; }
    public void setLogin(String login) { this.login = login; }
    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public Timestamp getDateCreation() { return dateCreation; }
    public void setDateCreation(Timestamp dateCreation) { this.dateCreation = dateCreation; }
    public boolean isActif() { return actif; }
    public void setActif(boolean actif) { this.actif = actif; }
}