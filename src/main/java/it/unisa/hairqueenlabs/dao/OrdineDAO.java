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
    
    //Metodo per recuperare tutti gli ordini di un singolo utente
    public List<Ordine> doRetrieveByUtente(int idUtente) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        List<Ordine> ordiniUtente = new java.util.ArrayList<>();

        //prende tutti gli ordini di questo id, ordinandoli dal più recente al più vecchio
        String query = "SELECT * FROM Ordine WHERE id_utente = ? ORDER BY data_ordine DESC";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, idUtente);

            rs = ps.executeQuery();

            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setIdOrdine(rs.getInt("id_ordine"));
                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                ordine.setTotale(rs.getDouble("totale"));
                ordine.setStato(rs.getString("stato"));
                ordine.setIdUtente(rs.getInt("id_utente"));

                ordiniUtente.add(ordine);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (connection != null) DriverManagerConnectionPool.releaseConnection(connection);
        }

        return ordiniUtente;
    }
    
    // Metodo per recuperare i dettagli di un ordine
    public List<DettaglioOrdine> doRetrieveDettagli(int idOrdine, int idUtente) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<DettaglioOrdine> dettagli = new java.util.ArrayList<>();

        String query = "SELECT d.id_prodotto, d.quantita_acquistata, d.prezzo_unitario, p.nome " +
                       "FROM Dettaglio_Ordine d " +
                       "JOIN Prodotto p ON d.id_prodotto = p.id_prodotto " +
                       "JOIN Ordine o ON d.id_ordine = o.id_ordine " +
                       "WHERE d.id_ordine = ? AND o.id_utente = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, idOrdine);
            ps.setInt(2, idUtente); // Se un utente cerca di vedere l'ordine di un altro, la query restituirà vuoto!
            rs = ps.executeQuery();

            while (rs.next()) {
                DettaglioOrdine dett = new DettaglioOrdine();
                dett.setIdProdotto(rs.getInt("id_prodotto"));
                dett.setQuantitaAcquistata(rs.getInt("quantita_acquistata"));
                dett.setPrezzoUnitario(rs.getDouble("prezzo_unitario"));
                dett.setNomeProdotto(rs.getString("nome")); // Il campo che abbiamo appena aggiunto!
                
                dettagli.add(dett);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (connection != null) DriverManagerConnectionPool.releaseConnection(connection);
        }
        return dettagli;
    }
    
    public List<Ordine> doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        List<Ordine> tuttiGliOrdini = new java.util.ArrayList<>();

        String query = "SELECT * FROM Ordine ORDER BY data_ordine DESC";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setIdOrdine(rs.getInt("id_ordine"));
                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                ordine.setTotale(rs.getDouble("totale"));
                ordine.setStato(rs.getString("stato"));
                ordine.setIdUtente(rs.getInt("id_utente"));

                tuttiGliOrdini.add(ordine);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (connection != null) DriverManagerConnectionPool.releaseConnection(connection);
        }

        return tuttiGliOrdini;
    }
    
    //Metodo per l'admin: aggiorna lo stato di un ordine esistente
    public synchronized boolean doUpdateStato(int idOrdine, String nuovoStato) throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        int result = 0;

        String query = "UPDATE Ordine SET stato = ? WHERE id_ordine = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, nuovoStato);
            ps.setInt(2, idOrdine);

            result = ps.executeUpdate();
            connection.commit();
        } finally {
            if (ps != null) ps.close();
            if (connection != null) DriverManagerConnectionPool.releaseConnection(connection);
        }

        return (result > 0);
    }
}