package com.banque.model;

import java.math.BigDecimal;

public class Client {
    private int idClient;
    private int idUser;
    private String ville;
    private String codePostal;
    private BigDecimal revenuMensuel;

    public Client() {}

    public int getIdClient() { return idClient; }
    public void setIdClient(int idClient) { this.idClient = idClient; }
    public int getIdUser() { return idUser; }
    public void setIdUser(int idUser) { this.idUser = idUser; }
    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }
    public String getCodePostal() { return codePostal; }
    public void setCodePostal(String codePostal) { this.codePostal = codePostal; }
    public BigDecimal getRevenuMensuel() { return revenuMensuel; }
    public void setRevenuMensuel(BigDecimal revenuMensuel) { this.revenuMensuel = revenuMensuel; }
}