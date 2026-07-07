package it.unisa.hairqueenlabs.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Recensione implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int idRecensione;
    private int voto;
    private String testo;
    private Timestamp dataRecensione;
    private int idUtente;
    private int idProdotto;
    private String nomeUtente;

    public Recensione() {}

    public int getIdRecensione() { return idRecensione; }
    public void setIdRecensione(int idRecensione) { this.idRecensione = idRecensione; }

    public int getVoto() { return voto; }
    public void setVoto(int voto) { this.voto = voto; }

    public String getTesto() { return testo; }
    public void setTesto(String testo) { this.testo = testo; }

    public Timestamp getDataRecensione() { return dataRecensione; }
    public void setDataRecensione(Timestamp dataRecensione) { this.dataRecensione = dataRecensione; }

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }

    public String getNomeUtente() { return nomeUtente; }
    public void setNomeUtente(String nomeUtente) { this.nomeUtente = nomeUtente; }
}