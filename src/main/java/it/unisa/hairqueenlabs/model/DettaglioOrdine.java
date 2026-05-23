package it.unisa.hairqueenlabs.model;

public class DettaglioOrdine {
	private int idOrdine;
	private int idProdotto;
	private int quantitaAcquistata;
	private double prezzoUnitario;
	private String nomeProdotto;
	
	public DettaglioOrdine(){
		
	}

	public DettaglioOrdine(int idOrdine, int idProdotto, int quantitaAcquistata, double prezzoUnitario, String nomeProdotto) {
		super();
		this.idOrdine = idOrdine;
		this.idProdotto = idProdotto;
		this.quantitaAcquistata = quantitaAcquistata;
		this.prezzoUnitario = prezzoUnitario;
		this.nomeProdotto = nomeProdotto;
	}

	public int getIdOrdine() {
		return idOrdine;
	}

	public void setIdOrdine(int idOrdine) {
		this.idOrdine = idOrdine;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public int getQuantitaAcquistata() {
		return quantitaAcquistata;
	}

	public void setQuantitaAcquistata(int quantitaAcquistata) {
		this.quantitaAcquistata = quantitaAcquistata;
	}

	public double getPrezzoUnitario() {
		return prezzoUnitario;
	}

	public void setPrezzoUnitario(double prezzoUnitario) {
		this.prezzoUnitario = prezzoUnitario;
	}

	public String getNomeProdotto() {
		return nomeProdotto;
	}

	public void setNomeProdotto(String nomeProdotto) {
		this.nomeProdotto = nomeProdotto;
	}

}
