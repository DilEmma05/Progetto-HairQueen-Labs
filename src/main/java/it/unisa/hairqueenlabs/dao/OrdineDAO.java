package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import it.unisa.hairqueenlabs.model.DettaglioOrdine;
import it.unisa.hairqueenlabs.model.Ordine;

public class OrdineDAO {

    public synchronized boolean doSaveTransaction(Ordine ordine, List<DettaglioOrdine> carrello) throws SQLException {
        Connection connection = null;
        PreparedStatement psOrdine = null;
        PreparedStatement psDettaglio = null;
        ResultSet rsKeys = null;

        try {
            connection = DriverManagerConnectionPool.getConnection();
            
            //DISABILITIAMO L'AUTOCOMMIT (Inizio Transazione)
            connection.setAutoCommit(false);

            //SALVA L'ORDINE PRINCIPALE
            String sqlOrdine = "INSERT INTO Ordine (totale, stato, id_utente) VALUES (?, ?, ?)";
            psOrdine = connection.prepareStatement(sqlOrdine, Statement.RETURN_GENERATED_KEYS);
            psOrdine.setDouble(1, ordine.getTotale());
            psOrdine.setString(2, ordine.getStato());
            psOrdine.setInt(3, ordine.getIdUtente());

            psOrdine.executeUpdate();

            //RECUPERIAMO L'ID
            rsKeys = psOrdine.getGeneratedKeys();
            int idNuovoOrdine = -1;
            if (rsKeys.next()) {
                idNuovoOrdine = rsKeys.getInt(1);
            }

            //SALVIAMO I DETTAGLI
            String sqlDettaglio = "INSERT INTO Dettaglio_Ordine (id_ordine, id_prodotto, quantita_acquistata, prezzo_unitario) VALUES (?, ?, ?, ?)";
            psDettaglio = connection.prepareStatement(sqlDettaglio);

            // Facciamo un ciclo per ogni prodotto nel carrello
            for (DettaglioOrdine item : carrello) {
                psDettaglio.setInt(1, idNuovoOrdine);
                psDettaglio.setInt(2, item.getIdProdotto());
                psDettaglio.setInt(3, item.getQuantitaAcquistata());
                psDettaglio.setDouble(4, item.getPrezzoUnitario());
                
                psDettaglio.executeUpdate();
            }

            connection.commit();
            return true;

        } catch (SQLException e) {
            // SE C'È UN ERRORE, ANNULLIAMO TUTTO
            if (connection != null) {
                System.err.println("Errore rilevato: Rollback della transazione in corso...");
                connection.rollback();
            }
            e.printStackTrace();
            return false;
            
        } finally {
            // RIPRISTINIAMO LE IMPOSTAZIONI ORIGINALI E CHUDIAMO I CORRIERI
            if (connection != null) {
                connection.setAutoCommit(true); 
            }
            if (rsKeys != null) rsKeys.close();
            if (psOrdine != null) psOrdine.close();
            if (psDettaglio != null) psDettaglio.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
    }
}