package it.unisa.hairqueenlabs.model;

import java.io.Serializable;

public class Categoria implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int idCategoria;
	private String nomeCategoria;
	
	public Categoria() {
		
	}

	public Categoria(int idCategoria, String nomeCategoria) {
		this.idCategoria = idCategoria;
		this.nomeCategoria = nomeCategoria;
	}

	public int getIdCategoria() {
		return idCategoria;
	}

	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}

	public String getNomeCategoria() {
		return nomeCategoria;
	}

	public void setNomeCategoria(String nomeCategoria) {
		this.nomeCategoria = nomeCategoria;
	}

}
