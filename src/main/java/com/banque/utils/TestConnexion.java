package com.banque.utils;

import java.sql.Connection;

public class TestConnexion {
    public static void main(String[] args) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            System.out.println("Félicitations ! Votre architecture JEE est connectée à PostgreSQL.");
        } else {
            System.out.println("Échec de la connexion. Vérifiez l'URL, l'utilisateur ou le mot de passe.");
        }
    }
}