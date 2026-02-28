package com.banque.service;
import com.banque.model.Client;

public interface IClientService {
    void inscrireClientInitial(String nom, String prenom, String email, String password);
    void completerProfilFinancier(Client client);
}