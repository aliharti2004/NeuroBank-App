package com.banque.dao;

import com.banque.model.PredictionIA;
import com.banque.utils.DBConnection;
import java.sql.*;

public class PredictionDAOImpl implements IPredictionDAO {

    @Override
    public void insert(PredictionIA p) {
        String sql = "INSERT INTO t_prediction (id_demande, score_risque, probabilite_defaut, recommandation) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getIdDemande());
            ps.setInt(2, p.getScoreRisque());
            ps.setBigDecimal(3, p.getProbabiliteDefaut());
            ps.setString(4, p.getRecommandation());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public PredictionIA findByDemandeId(int idDemande) {
        String sql = "SELECT * FROM t_prediction WHERE id_demande = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idDemande);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PredictionIA p = new PredictionIA();
                p.setIdPrediction(rs.getInt("id_prediction"));
                p.setIdDemande(rs.getInt("id_demande"));
                p.setScoreRisque(rs.getInt("score_risque"));
                p.setProbabiliteDefaut(rs.getBigDecimal("probabilite_defaut"));
                p.setRecommandation(rs.getString("recommandation"));
                p.setDateAnalyse(rs.getTimestamp("date_analyse"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(PredictionIA p) {
        String sql = "UPDATE t_prediction SET score_risque = ?, probabilite_defaut = ?, recommandation = ?, date_analyse = CURRENT_TIMESTAMP WHERE id_prediction = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getScoreRisque());
            ps.setBigDecimal(2, p.getProbabiliteDefaut());
            ps.setString(3, p.getRecommandation());
            ps.setInt(4, p.getIdPrediction());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}