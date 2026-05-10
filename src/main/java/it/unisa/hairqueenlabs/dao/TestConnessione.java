package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnessione {
    public static void main(String[] args) {
        System.out.println("--- Test Connessione HairQueen Labs ---");
        
        try {
            Connection conn = DriverManagerConnectionPool.getConnection();
            
            if (conn != null) {
                System.out.println("SUCCESSO! Il ponte tra Java e MySQL funziona.");
                System.out.println("Database collegato: " + conn.getCatalog());
                
                DriverManagerConnectionPool.releaseConnection(conn);
                System.out.println("Connessione rilasciata con successo.");
            }
        } catch (SQLException e) {
            System.err.println("ERRORE: Impossibile collegarsi al database!");
            System.err.println("Motivo: " + e.getMessage());
            e.printStackTrace();
        }
    }
}