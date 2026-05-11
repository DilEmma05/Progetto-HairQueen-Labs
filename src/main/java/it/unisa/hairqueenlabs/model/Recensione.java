package it.unisa.hairqueenlabs.model;

import java.sql.Timestamp;

public class Recensione {
    private int idRecensione;
    private int voto;
    private String testo;
    private Timestamp dataRecensione;
    private int idUtente;
    private int idProdotto;
    
    public Recensione() {

    }

	public Recensione(int idRecensione, int voto, String testo, Timestamp dataRecensione, int idUtente,
			int idProdotto) {
		super();
		this.idRecensione = idRecensione;
		this.voto = voto;
		this.testo = testo;
		this.dataRecensione = dataRecensione;
		this.idUtente = idUtente;
		this.idProdotto = idProdotto;
	}

	public int getIdRecensione() {
		return idRecensione;
	}

	public void setIdRecensione(int idRecensione) {
		this.idRecensione = idRecensione;
	}

	public int getVoto() {
		return voto;
	}

	public void setVoto(int voto) {
		this.voto = voto;
	}

	public String getTesto() {
		return testo;
	}

	public void setTesto(String testo) {
		this.testo = testo;
	}

	public Timestamp getDataRecensione() {
		return dataRecensione;
	}

	public void setDataRecensione(Timestamp dataRecensione) {
		this.dataRecensione = dataRecensione;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}
    
}