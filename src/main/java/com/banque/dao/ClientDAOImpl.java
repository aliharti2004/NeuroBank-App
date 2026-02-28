package com.banque.dao;

import com.banque.model.Client;
import com.banque.utils.DBConnection;
import java.sql.*;

public class ClientDAOImpl implements IClientDAO {

    @Override
    public Client insert(Client c) {
        String sql = "INSERT INTO t_client (id_client, id_user, ville, code_postal, revenu_mensuel) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getIdClient());
            ps.setInt(2, c.getIdUser());
            ps.setString(3, c.getVille());
            ps.setString(4, c.getCodePostal());
            ps.setBigDecimal(5, c.getRevenuMensuel());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    @Override
    public Client findById(int idClient) {
        String sql = "SELECT * FROM t_client WHERE id_client = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idClient);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Client c = new Client();
                c.setIdClient(rs.getInt("id_client"));
                c.setIdUser(rs.getInt("id_user"));
                c.setVille(rs.getString("ville"));
                c.setCodePostal(rs.getString("code_postal"));
                c.setRevenuMensuel(rs.getBigDecimal("revenu_mensuel"));
                return c;
            }
        } catch (SQLException e) {
            System.err.println("Erreur DAO Client : " + e.getMessage());
        }
        return null;
    }

    @Override
    public void creerProfilVide(Client c) {
        // On insère uniquement l'id_user pour créer la ligne
        String sql = "INSERT INTO t_client (id_user, ville, code_postal, revenu_mensuel) VALUES (?, '', '', 0)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getIdUser());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateFinancials(Client c) {
        // Solution robuste : vérifier si le profil existe, puis UPDATE ou INSERT
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();

            // 1. Vérifier si le client existe déjà
            String checkSql = "SELECT id_client FROM t_client WHERE id_user = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, c.getIdUser());
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // Client existe déjà → UPDATE
                String updateSql = "UPDATE t_client SET ville = ?, code_postal = ?, revenu_mensuel = ? WHERE id_user = ?";
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setString(1, c.getVille());
                updatePs.setString(2, c.getCodePostal());
                updatePs.setBigDecimal(3, c.getRevenuMensuel());
                updatePs.setInt(4, c.getIdUser());

                int rows = updatePs.executeUpdate();
                System.out.println(">>> Profil CLIENT mis à jour (UPDATE) pour id_user=" + c.getIdUser() + " (" + rows
                        + " ligne(s))");
                updatePs.close();
            } else {
                // Client n'existe pas → INSERT (id_client sera auto-généré par SERIAL ou
                // DEFAULT)
                String insertSql = "INSERT INTO t_client (id_user, ville, code_postal, revenu_mensuel) VALUES (?, ?, ?, ?)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, c.getIdUser());
                insertPs.setString(2, c.getVille());
                insertPs.setString(3, c.getCodePostal());
                insertPs.setBigDecimal(4, c.getRevenuMensuel());

                int rows = insertPs.executeUpdate();
                System.out.println(
                        ">>> Profil CLIENT créé (INSERT) pour id_user=" + c.getIdUser() + " (" + rows + " ligne(s))");
                insertPs.close();
            }

            rs.close();
            checkPs.close();

        } catch (SQLException e) {
            System.err.println("ERREUR updateFinancials : " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public Client findByUserId(int idUser) {
        String sql = "SELECT * FROM t_client WHERE id_user = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUser);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Client c = new Client();
                c.setIdClient(rs.getInt("id_client"));
                c.setIdUser(rs.getInt("id_user"));
                c.setVille(rs.getString("ville"));
                c.setCodePostal(rs.getString("code_postal"));
                c.setRevenuMensuel(rs.getBigDecimal("revenu_mensuel"));
                return c;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
