package com.banque.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Configuration locale (fallback si pas de variable d'environnement)
    private static final String LOCAL_URL = "jdbc:postgresql://localhost:5432/bank_prets";
    private static final String LOCAL_USER = "postgres";
    private static final String LOCAL_PASSWORD = "2004@Ali..";

    /**
     * Méthode statique pour obtenir une connexion à la base de données.
     * Supporte Railway (DATABASE_URL) et configuration locale.
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Chargement du driver JDBC PostgreSQL
            Class.forName("org.postgresql.Driver");

            // Vérifier si on est sur Railway (variable d'environnement DATABASE_URL)
            String databaseUrl = System.getenv("DATABASE_URL");

            if (databaseUrl != null && !databaseUrl.isEmpty()) {
                // RAILWAY PRODUCTION: Utiliser DATABASE_URL
                System.out.println(">>> Connexion Railway avec DATABASE_URL");
                connection = DriverManager.getConnection(databaseUrl);
            } else {
                // LOCAL DEVELOPMENT: Utiliser configuration locale
                System.out.println(">>> Connexion locale à bank_prets");
                connection = DriverManager.getConnection(LOCAL_URL, LOCAL_USER, LOCAL_PASSWORD);
            }

            if (connection != null) {
                System.out.println(">>> Connexion réussie à la base de données!");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Erreur : Driver PostgreSQL introuvable. Vérifiez votre pom.xml.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Erreur : Impossible de se connecter à la base de données.");
            System.err.println("Détails : " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
}