package com.banque.test;

import com.banque.model.*;
import com.banque.service.*;
import java.math.BigDecimal;

public class MainTestService {
    public static void main(String[] args) {
        System.out.println("--- DÉBUT DES TESTS DE LA COUCHE SERVICE ---");

        // Initialisation des implémentations
        IAuthService authService = new AuthServiceImpl();
        IClientService clientService = new ClientServiceImpl();
        IPretService pretService = new PretServiceImpl();

        try {
            // TEST 1 : Authentification (Règle 4.1.2)
            System.out.println("\n[Test 1] Connexion de 'client1'...");
            Utilisateur user = authService.login("client1", "password123");
            
            if (user != null) {
                System.out.println("SUCCÈS : Utilisateur connecté (Rôle: " + user.getRole() + ")");

                // TEST 2 : Complétude du Profil Financier (Règle 4.1.4)
                System.out.println("\n[Test 2] Mise à jour des données financières...");
                Client c = new Client();
                c.setIdUser(user.getIdUser());
                c.setVille("CASABLANCA");
                c.setCodePostal("20000");
                c.setRevenuMensuel(new BigDecimal("8500.00"));
                
                clientService.completerProfilFinancier(c);
                System.out.println("SUCCÈS : Profil financier persisté pour les futures demandes.");

                // TEST 3 : Soumission de prêt avec calcul de mensualité (Règle 4.1.5)
                System.out.println("\n[Test 3] Soumission d'une demande de prêt immobilier...");
                DemandePret d = new DemandePret();
                d.setIdClient(1); // ID récupéré depuis la base
                d.setTypePret("immobilier");
                d.setMontantPret(new BigDecimal("600000.00"));
                d.setDureeMois(180); // 15 ans
                d.setTauxInteret(new BigDecimal("4.5"));

                // Le service doit calculer la mensualité et assigner un agent
                DemandePret result = pretService.soumettreNouvelleDemande(d);
                
                System.out.println("SUCCÈS : Demande ID " + result.getIdDemande() + " enregistrée.");
                System.out.println("INFO : Vérifiez la console pour le calcul de la mensualité.");
                System.out.println("INFO : Vérifiez psql pour l'attribution automatique de l'agent.");
            } else {
                System.out.println("ERREUR : Échec de l'authentification. Vérifiez le login/password.");
            }

        } catch (Exception e) {
            System.err.println("ERREUR CRITIQUE : " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("\n--- FIN DES TESTS SERVICE ---");
    }
}