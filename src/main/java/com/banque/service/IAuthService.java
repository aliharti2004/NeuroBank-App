package com.banque.service;
import com.banque.model.Utilisateur;

public interface IAuthService {
    Utilisateur login(String login, String password);
}