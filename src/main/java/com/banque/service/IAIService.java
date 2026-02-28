package com.banque.service;

import com.banque.model.PredictionIA;
import com.banque.model.DemandePret;

public interface IAIService {
    // Envoie les données à l'IA et retourne l'objet de prédiction
    PredictionIA analyserDemande(DemandePret demande);
}