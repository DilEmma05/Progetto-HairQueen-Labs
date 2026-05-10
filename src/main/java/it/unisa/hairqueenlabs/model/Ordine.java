package it.unisa.hairqueenlabs.model;

import java.sql.Timestamp;

public class Ordine {
	private int idOrdine;
	private Timestamp dataOrdine;
	private double totale;
	private String stato;
	private int idUtente;
	
	public Ordine() {
		
	}

	public Ordine(int idOrdine, Timestamp dataOrdine, double totale, String stato, int idUtente) {
		super();
		this.idOrdine = idOrdine;
		this.dataOrdine = dataOrdine;
		this.totale = totale;
		this.stato = stato;
		this.idUtente = idUtente;
	}

	public int getIdOrdine() {
		return idOrdine;
	}

	public void setIdOrdine(int idOrdine) {
		this.idOrdine = idOrdine;
	}

	public Timestamp getDataOrdine() {
		return dataOrdine;
	}

	public void setDataOrdine(Timestamp dataOrdine) {
		this.dataOrdine = dataOrdine;
	}

	public double getTotale() {
		return totale;
	}

	public void setTotale(double totale) {
		this.totale = totale;
	}

	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}

}
