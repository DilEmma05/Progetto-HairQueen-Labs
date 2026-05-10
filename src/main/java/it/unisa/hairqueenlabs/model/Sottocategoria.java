package it.unisa.hairqueenlabs.model;

public class Sottocategoria {
	private int idSottocategoria;
	private String nomeSottocategoria;
	private int idCategoria;
	
	public Sottocategoria(){
		
	}

	public Sottocategoria(int idSottocategoria, String nomeSottocategoria, int idCategoria) {
		super();
		this.idSottocategoria = idSottocategoria;
		this.nomeSottocategoria = nomeSottocategoria;
		this.idCategoria = idCategoria;
	}

	public int getIdSottocategoria() {
		return idSottocategoria;
	}

	public void setIdSottocategoria(int idSottocategoria) {
		this.idSottocategoria = idSottocategoria;
	}

	public String getNomeSottocategoria() {
		return nomeSottocategoria;
	}

	public void setNomeSottocategoria(String nomeSottocategoria) {
		this.nomeSottocategoria = nomeSottocategoria;
	}

	public int getIdCategoria() {
		return idCategoria;
	}

	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}

}
