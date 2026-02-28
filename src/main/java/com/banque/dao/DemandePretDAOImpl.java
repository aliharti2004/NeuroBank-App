package com.banque.dao;

import com.banque.model.DemandePret;
import com.banque.model.Utilisateur;
import com.banque.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class DemandePretDAOImpl implements IDemandePretDAO {

    @Override
    public DemandePret insert(DemandePret d) {
        String sql = "INSERT INTO t_demande_pret (id_client, type_pret, montant_pret, duree_mois, taux_interet, mensualite) "
                +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, d.getIdClient());
            ps.setString(2, d.getTypePret());
            ps.setBigDecimal(3, d.getMontantPret());
            ps.setInt(4, d.getDureeMois());
            ps.setBigDecimal(5, d.getTauxInteret());
            ps.setBigDecimal(6, d.getMensualite());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next())
                d.setIdDemande(rs.getInt(1));

            System.out.println(">>> Demande insérée : ID=" + d.getIdDemande() +
                    ", Montant=" + d.getMontantPret() +
                    ", Durée=" + d.getDureeMois() +
                    ", Mensualité=" + d.getMensualite());

            // Attribution automatique immédiate après l'insertion
            assignAgentAuto(d.getIdDemande());
        } catch (SQLException e) {
            System.err.println("ERREUR insert DemandePret : " + e.getMessage());
            e.printStackTrace();
        }
        return d;
    }

    @Override
    public void assignAgentAuto(int idDemande) {
        IUtilisateurDAO userDAO = new UtilisateurDAOImpl();
        List<Utilisateur> agents = userDAO.findAllAgents();
        if (!agents.isEmpty()) {
            // Logique simple : On choisit un agent au hasard parmi les actifs
            int agentId = agents.get(new Random().nextInt(agents.size())).getIdUser();
            String sql = "UPDATE t_demande_pret SET id_agent = ? WHERE id_demande = ?";
            try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, agentId);
                ps.setInt(2, idDemande);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void updateStatus(int idDemande, String nouveauStatut) {
        String sql = "UPDATE t_demande_pret SET statut = ?, date_decision = CURRENT_TIMESTAMP WHERE id_demande = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nouveauStatut);
            ps.setInt(2, idDemande);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<DemandePret> findByStatus(String statut) {
        List<DemandePret> list = new ArrayList<>();
        String sql = "SELECT * FROM t_demande_pret WHERE statut = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, statut);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DemandePret d = new DemandePret();
                d.setIdDemande(rs.getInt("id_demande"));
                d.setMontantPret(rs.getBigDecimal("montant_pret"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public DemandePret findById(int id) {
        DemandePret demande = null;
        String sql = "SELECT * FROM t_demande_pret WHERE id_demande = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                demande = new DemandePret();
                demande.setIdDemande(rs.getInt("id_demande"));
                demande.setIdClient(rs.getInt("id_client"));

                // id_agent peut être NULL
                Integer idAgent = (Integer) rs.getObject("id_agent");
                demande.setIdAgent(idAgent);

                demande.setTypePret(rs.getString("type_pret"));
                demande.setMontantPret(rs.getBigDecimal("montant_pret"));
                demande.setDureeMois(rs.getInt("duree_mois"));
                demande.setTauxInteret(rs.getBigDecimal("taux_interet"));
                demande.setMensualite(rs.getBigDecimal("mensualite"));
                demande.setStatut(rs.getString("statut"));
                demande.setDateCreation(rs.getTimestamp("date_creation"));
                demande.setDateDecision(rs.getTimestamp("date_decision"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return demande;
    }

    @Override
    public List<DemandePret> findByClientId(int idClient) {
        List<DemandePret> list = new ArrayList<>();
        String sql = "SELECT * FROM t_demande_pret WHERE id_client = ? ORDER BY date_creation DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idClient);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DemandePret d = new DemandePret();
                d.setIdDemande(rs.getInt("id_demande"));
                d.setIdClient(rs.getInt("id_client"));

                // id_agent peut être NULL
                Integer idAgent = (Integer) rs.getObject("id_agent");
                d.setIdAgent(idAgent);

                d.setTypePret(rs.getString("type_pret"));
                d.setMontantPret(rs.getBigDecimal("montant_pret"));
                d.setDureeMois(rs.getInt("duree_mois"));
                d.setTauxInteret(rs.getBigDecimal("taux_interet"));
                d.setMensualite(rs.getBigDecimal("mensualite"));
                d.setStatut(rs.getString("statut"));
                d.setDateCreation(rs.getTimestamp("date_creation"));
                d.setDateDecision(rs.getTimestamp("date_decision"));

                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Récupère toutes les demandes assignées à un agent spécifique.
     * Utilisé par le dashboard Agent pour afficher sa liste de travail.
     */
    @Override
    public List<DemandePret> findByAgentId(int idAgent) {
        List<DemandePret> list = new ArrayList<>();
        String sql = "SELECT * FROM t_demande_pret WHERE id_agent = ? ORDER BY date_creation DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idAgent);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DemandePret d = new DemandePret();
                d.setIdDemande(rs.getInt("id_demande"));
                d.setIdClient(rs.getInt("id_client"));

                Integer agent = (Integer) rs.getObject("id_agent");
                d.setIdAgent(agent);

                d.setTypePret(rs.getString("type_pret"));
                d.setMontantPret(rs.getBigDecimal("montant_pret"));
                d.setDureeMois(rs.getInt("duree_mois"));
                d.setTauxInteret(rs.getBigDecimal("taux_interet"));
                d.setStatut(rs.getString("statut"));
                d.setDateCreation(rs.getTimestamp("date_creation"));
                d.setDateDecision(rs.getTimestamp("date_decision"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<DemandePret> findAll() {
        List<DemandePret> list = new ArrayList<>();
        String sql = "SELECT * FROM t_demande_pret ORDER BY date_creation DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DemandePret d = new DemandePret();
                d.setIdDemande(rs.getInt("id_demande"));
                d.setIdClient(rs.getInt("id_client"));

                Integer agent = (Integer) rs.getObject("id_agent");
                d.setIdAgent(agent);

                d.setTypePret(rs.getString("type_pret"));
                d.setMontantPret(rs.getBigDecimal("montant_pret"));
                d.setDureeMois(rs.getInt("duree_mois"));
                d.setTauxInteret(rs.getBigDecimal("taux_interet"));
                d.setMensualite(rs.getBigDecimal("mensualite"));
                d.setStatut(rs.getString("statut"));
                d.setDateCreation(rs.getTimestamp("date_creation"));
                d.setDateDecision(rs.getTimestamp("date_decision"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void assignAgent(int idDemande, int idAgent) {
        String sql = "UPDATE t_demande_pret SET id_agent = ? WHERE id_demande = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idAgent);
            ps.setInt(2, idDemande);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}