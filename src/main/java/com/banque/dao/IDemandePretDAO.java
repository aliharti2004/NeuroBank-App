package com.banque.dao;

import com.banque.model.DemandePret;
import java.util.List;

public interface IDemandePretDAO {
    DemandePret insert(DemandePret demande);

    DemandePret findById(int id);

    List<DemandePret> findByClientId(int idClient);

    List<DemandePret> findByAgentId(int idAgent); // Pour le dashboard Agent

    List<DemandePret> findByStatus(String statut);

    void updateStatus(int idDemande, String nouveauStatut);

    void assignAgentAuto(int idDemande); // Attribution automatique

    // Méthodes pour l'interface Agent
    List<DemandePret> findAll();

    void assignAgent(int idDemande, int idAgent);
}