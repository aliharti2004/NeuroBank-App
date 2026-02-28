package com.banque.dao;

import com.banque.model.PredictionIA;

public interface IPredictionDAO {
    void insert(PredictionIA prediction);

    PredictionIA findByDemandeId(int idDemande); // Pour l'affichage côté Agent

    void update(PredictionIA prediction); // Pour mettre à jour une prédiction existante
}