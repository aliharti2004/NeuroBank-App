package com.banque.test;

import com.banque.dao.*;
import com.banque.model.*;
import java.math.BigDecimal;
import java.util.List;

public class MainTestDAO {
    public static void main(String[] args) {
        System.out.println("--- DÉBUT DES TESTS DAO ---");

        // 1. Initialisation des implémentations
        IUtilisateurDAO userDAO = new UtilisateurDAOImpl();
        IClientDAO clientDAO = new ClientDAOImpl();
        IDemandePretDAO demandeDAO = new DemandePretDAOImpl();

        try {
            // TEST A : Authentification / Recherche Utilisateur
            System.out.println("\n[Test A] Recherche de l'utilisateur 'client1'...");
            Utilisateur u = userDAO.findByLogin("client1");
            if (u != null) {
                System.out.println("SUCCÈS : Utilisateur trouvé (ID: " + u.getIdUser() + ", Rôle: " + u.getRole() + ")");
                
                // TEST B : Profil Client
                System.out.println("\n[Test B] Vérification du profil financier du client...");
                Client c = clientDAO.findByUserId(u.getIdUser());
                if (c != null) {
                    System.out.println("SUCCÈS : Client identifié (Ville: " + c.getVille() + ", Revenu: " + c.getRevenuMensuel() + "€)");
                    
                    // TEST C : Création d'une demande de prêt
                    System.out.println("\n[Test C] Création d'une nouvelle demande de prêt...");
                    DemandePret d = new DemandePret();
                    d.setIdClient(c.getIdClient());
                    d.setTypePret("immobilier");
                    d.setMontantPret(new BigDecimal("250000.00"));
                    d.setDureeMois(240);
                    d.setTauxInteret(new BigDecimal("3.5"));
                    
                    DemandePret nouvelleDemande = demandeDAO.insert(d);
                    System.out.println("SUCCÈS : Demande créée avec l'ID: " + nouvelleDemande.getIdDemande());

                    // TEST D : Vérification de l'attribution automatique (Exigence 4.2.3)
                    System.out.println("\n[Test D] Vérification de l'attribution automatique d'un agent...");
                    // On recharge la demande pour voir si l'ID agent a été mis à jour par le DAO
                    // (Normalement fait dans assignAgentAuto appelé par insert)
                    System.out.println("NOTE : Vérifiez en base (SELECT id_agent FROM t_demande_pret WHERE id_demande=" + nouvelleDemande.getIdDemande() + ")");
                } else {
                    System.out.println("ERREUR : Aucun client associé à cet utilisateur.");
                }
            } else {
                System.out.println("ERREUR : Utilisateur 'client1' non trouvé. Vérifiez vos données SQL.");
            }

        } catch (Exception e) {
            System.err.println("ÉCHEC CRITIQUE : " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("\n--- FIN DES TESTS DAO ---");
    }
}