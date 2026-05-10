package it.unisa.hairqueenlabs.dao;

import java.sql.SQLException;
import it.unisa.hairqueenlabs.model.Utente;

public class TestUtenteDAO {
    public static void main(String[] args) {
        System.out.println("--- Inizio Test Registrazione Utente HairQueen ---");

        Utente nuovoCliente = new Utente();
        nuovoCliente.setNome("Laura");
        nuovoCliente.setCognome("Bianchi");
        nuovoCliente.setEmail("laura.bianchi@email.it");
        nuovoCliente.setPassword("passwordSicura123");
        nuovoCliente.setIndirizzo("Via dello Shopping 5, Milano");
        nuovoCliente.setRuolo("CLIENTE");

        UtenteDAO dao = new UtenteDAO();

        try {
            System.out.println("Salvataggio nel database in corso...");
            dao.doSave(nuovoCliente);
            System.out.println("SUCCESSO! L'utente Laura Bianchi è stata registrata.");

            System.out.println("\n--- Lista Utenti presenti nel Database ---");
            for(Utente u : dao.doRetrieveAll()) {
                System.out.println("- " + u.getNome() + " " + u.getCognome() + " (" + u.getEmail() + ")");
            }

        } catch (SQLException e) {
            System.err.println("ERRORE DURANTE IL SALVATAGGIO!");
            e.printStackTrace();
        }
    }
}