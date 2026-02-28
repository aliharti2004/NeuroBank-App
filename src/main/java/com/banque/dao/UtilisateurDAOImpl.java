package com.banque.dao;

import com.banque.model.Utilisateur;
import com.banque.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAOImpl implements IUtilisateurDAO {

    @Override
    public int insert(Utilisateur u) {
        String sql = "INSERT INTO t_utilisateur (login, mot_de_passe, role, nom, prenom, date_creation, actif) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, true)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, u.getLogin());
            ps.setString(2, u.getMotDePasse());
            ps.setString(3, u.getRole());
            ps.setString(4, u.getNom());
            ps.setString(5, u.getPrenom());

            ps.executeUpdate();

            // Récupération de l'ID généré (ex: 230)
            java.sql.ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public Utilisateur findByLogin(String login) {
        // On récupère toutes les colonnes pour ne rien oublier (Nom, Prénom, Role)
        String sql = "SELECT * FROM t_utilisateur WHERE login = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Utilisateur u = new Utilisateur();
                u.setIdUser(rs.getInt("id_user"));
                u.setLogin(rs.getString("login"));
                u.setMotDePasse(rs.getString("mot_de_passe")); // Indispensable pour le check
                u.setNom(rs.getString("nom"));
                u.setPrenom(rs.getString("prenom"));
                u.setRole(rs.getString("role")); // Indispensable pour la redirection
                u.setActif(rs.getBoolean("actif"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Renvoie null si l'email n'existe pas
    }

    @Override
    public Utilisateur findById(int id) {
        String sql = "SELECT * FROM t_utilisateur WHERE id_user = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Utilisateur u = new Utilisateur();
                u.setIdUser(rs.getInt("id_user"));
                u.setLogin(rs.getString("login"));
                u.setMotDePasse(rs.getString("mot_de_passe"));
                u.setNom(rs.getString("nom"));
                u.setPrenom(rs.getString("prenom"));
                u.setRole(rs.getString("role"));
                u.setActif(rs.getBoolean("actif"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Utilisateur> findAllAgents() {
        List<Utilisateur> agents = new ArrayList<>();
        String sql = "SELECT * FROM t_utilisateur WHERE role = 'AGENT' AND actif = true";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Utilisateur u = new Utilisateur();
                u.setIdUser(rs.getInt("id_user"));
                agents.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return agents;
    }

    @Override
    public int countByRole(String role) {
        String sql = "SELECT COUNT(*) FROM t_utilisateur WHERE role = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Utilisateur> findAll() {
        List<Utilisateur> users = new ArrayList<>();
        String sql = "SELECT * FROM t_utilisateur ORDER BY date_creation DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Utilisateur u = new Utilisateur();
                u.setIdUser(rs.getInt("id_user"));
                u.setLogin(rs.getString("login"));
                u.setNom(rs.getString("nom"));
                u.setPrenom(rs.getString("prenom"));
                u.setRole(rs.getString("role"));
                u.setActif(rs.getBoolean("actif"));
                u.setDateCreation(rs.getTimestamp("date_creation"));
                users.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public boolean update(Utilisateur u) {
        // If password is empty, don't update it
        String sql;
        if (u.getMotDePasse() == null || u.getMotDePasse().trim().isEmpty()) {
            sql = "UPDATE t_utilisateur SET login = ?, nom = ?, prenom = ?, role = ?, actif = ? WHERE id_user = ?";
        } else {
            sql = "UPDATE t_utilisateur SET login = ?, mot_de_passe = ?, nom = ?, prenom = ?, role = ?, actif = ? WHERE id_user = ?";
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setString(paramIndex++, u.getLogin());

            if (u.getMotDePasse() != null && !u.getMotDePasse().trim().isEmpty()) {
                ps.setString(paramIndex++, u.getMotDePasse());
            }

            ps.setString(paramIndex++, u.getNom());
            ps.setString(paramIndex++, u.getPrenom());
            ps.setString(paramIndex++, u.getRole());
            ps.setBoolean(paramIndex++, u.isActif());
            ps.setInt(paramIndex++, u.getIdUser());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int userId) {
        String sql = "DELETE FROM t_utilisateur WHERE id_user = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}