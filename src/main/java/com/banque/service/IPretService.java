package com.banque.service;
import com.banque.model.DemandePret;

public interface IPretService {
    DemandePret soumettreNouvelleDemande(DemandePret demande);
}