package com.banque.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class PredictionIA {
    private int idPrediction;
    private int idDemande;
    private int scoreRisque;
    private BigDecimal probabiliteDefaut;
    private String recommandation;
    private Timestamp dateAnalyse;

    public PredictionIA() {}

    public int getIdPrediction() { return idPrediction; }
    public void setIdPrediction(int idPrediction) { this.idPrediction = idPrediction; }
    public int getIdDemande() { return idDemande; }
    public void setIdDemande(int idDemande) { this.idDemande = idDemande; }
    public int getScoreRisque() { return scoreRisque; }
    public void setScoreRisque(int scoreRisque) { this.scoreRisque = scoreRisque; }
    public BigDecimal getProbabiliteDefaut() { return probabiliteDefaut; }
    public void setProbabiliteDefaut(BigDecimal probabiliteDefaut) { this.probabiliteDefaut = probabiliteDefaut; }
    public String getRecommandation() { return recommandation; }
    public void setRecommandation(String recommandation) { this.recommandation = recommandation; }
    public Timestamp getDateAnalyse() { return dateAnalyse; }
    public void setDateAnalyse(Timestamp dateAnalyse) { this.dateAnalyse = dateAnalyse; }
}