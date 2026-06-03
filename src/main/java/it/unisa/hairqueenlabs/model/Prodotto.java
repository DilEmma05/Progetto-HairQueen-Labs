package it.unisa.hairqueenlabs.model;

public class Prodotto {
	private int idProdotto;
	private String nome;
	private String descrizione;
	private double prezzo;
	private int quantitaMagazzino;
	private String immagineUrl;
	private String faseUtilizzo;
	private int idSottocategoria;
	private String tipoCuteTarget;
	private String tipoCapelloTarget;
	private boolean isNovita;
	
	public Prodotto(){
		
	}

	public Prodotto(int idProdotto, String nome, String descrizione, double prezzo, int quantitaMagazzino,
			String immagineUrl, String faseUtilizzo, int idSottocategoria, String tipoCuteTarget, String tipoCapelloTarget, boolean isNovita) {
		super();
		this.idProdotto = idProdotto;
		this.nome = nome;
		this.descrizione = descrizione;
		this.prezzo = prezzo;
		this.quantitaMagazzino = quantitaMagazzino;
		this.immagineUrl = immagineUrl;
		this.faseUtilizzo = faseUtilizzo;
		this.idSottocategoria = idSottocategoria;
		this.tipoCuteTarget = tipoCuteTarget;
		this.tipoCapelloTarget = tipoCapelloTarget;
		this.isNovita = isNovita;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public int getQuantitaMagazzino() {
		return quantitaMagazzino;
	}

	public void setQuantitaMagazzino(int quantitaMagazzino) {
		this.quantitaMagazzino = quantitaMagazzino;
	}

	public String getImmagineUrl() {
		return immagineUrl;
	}

	public void setImmagineUrl(String immagineUrl) {
		this.immagineUrl = immagineUrl;
	}

	public String getFaseUtilizzo() {
		return faseUtilizzo;
	}

	public void setFaseUtilizzo(String faseUtilizzo) {
		this.faseUtilizzo = faseUtilizzo;
	}

	public int getIdSottocategoria() {
		return idSottocategoria;
	}

	public void setIdSottocategoria(int idSottocategoria) {
		this.idSottocategoria = idSottocategoria;
	}

	public String getTipoCuteTarget() {
		return tipoCuteTarget;
	}

	public void setTipoCuteTarget(String tipoCuteTarget) {
		this.tipoCuteTarget = tipoCuteTarget;
	}

	public String getTipoCapelloTarget() {
		return tipoCapelloTarget;
	}

	public void setTipoCapelloTarget(String tipoCapelloTarget) {
		this.tipoCapelloTarget = tipoCapelloTarget;
	}

	public boolean isNovita() {
		return isNovita;
	}

	public void setNovita(boolean isNovita) {
		this.isNovita = isNovita;
	}

}