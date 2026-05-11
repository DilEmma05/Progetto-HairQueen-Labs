package it.unisa.hairqueenlabs.dao;

import it.unisa.hairqueenlabs.model.Recensione;
import it.unisa.hairqueenlabs.model.Prodotto;
import java.sql.SQLException;
import java.util.List;

public class TestAggiuntaFunzioneRecensione {
    public static void main(String[] args) {
        System.out.println("--- Inizio Test Hair Routine e Recensioni ---");

        try {
            // TEST 1: ROUTINE FINDER
            ProdottoDAO pDao = new ProdottoDAO();
            System.out.println("\n1. Cerco prodotti per Cute Grassa e Capelli Ricci...");
            List<Prodotto> consigliati = pDao.doRetrieveRaccomandati("Grassa", "Riccio");
            System.out.println("SUCCESSO! La query funziona. Prodotti trovati: " + consigliati.size());

            // TEST 2: RECENSIONI
            RecensioneDAO rDao = new RecensioneDAO();
            Recensione r = new Recensione();
            r.setVoto(5);
            r.setTesto("Shampoo fantastico, fa miracoli sui miei capelli!");
            
            r.setIdUtente(1); 
            r.setIdProdotto(1); 

            System.out.println("\n2. Provo a salvare una recensione...");
            rDao.doSave(r);
            System.out.println("SUCCESSO! Recensione salvata nel database.");

        } catch (SQLException e) {
            System.err.println("ERRORE DURANTE IL TEST!");
            e.printStackTrace();
        }
    }
}