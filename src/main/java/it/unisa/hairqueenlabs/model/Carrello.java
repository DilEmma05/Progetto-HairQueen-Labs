package it.unisa.hairqueenlabs.model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {

    private List<ElementoCarrello> elementi;

    public Carrello() {
        this.elementi = new ArrayList<>();
    }

    public List<ElementoCarrello> getElementi() {
        return elementi;
    }

    // Aggiunge un prodotto al carrello o ne incrementa la quantità se esiste già
    public void aggiungiProdotto(Prodotto prodotto) {
        for (ElementoCarrello elemento : elementi) {
            if (elemento.getProdotto().getIdProdotto() == prodotto.getIdProdotto()) {
                elemento.incrementaQuantita();
                return;
            }
        }
        elementi.add(new ElementoCarrello(prodotto));
    }

    // Rimuove un prodotto dal carrello
    public void rimuoviProdotto(int idProdotto) {
        elementi.removeIf(elemento -> elemento.getProdotto().getIdProdotto() == idProdotto);
    }

    // Calcola il prezzo totale del carrello
    public double getPrezzoTotale() {
        double totale = 0;
        for (ElementoCarrello elemento : elementi) {
            totale += elemento.getProdotto().getPrezzo() * elemento.getQuantita();
        }
        return totale;
    }

    public static class ElementoCarrello {
        private Prodotto prodotto;
        private int quantita;

        public ElementoCarrello(Prodotto prodotto) {
            this.prodotto = prodotto;
            this.quantita = 1;
        }

        public Prodotto getProdotto() { return prodotto; }
        public int getQuantita() { return quantita; }
        public void incrementaQuantita() { this.quantita++; }
        public void setQuantita(int quantita) { this.quantita = quantita; }
    }

    public int getNumeroTotaleArticoli() {
        int totale = 0;
        for (ElementoCarrello elemento : elementi) {
            totale += elemento.getQuantita();
        }
        return totale;
    }
}