package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import it.unisa.hairqueenlabs.model.Prodotto;

public class ProdottoDAO {
	
    public synchronized List<Prodotto> doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Prodotto> prodotti = new ArrayList<>();
        String selectSQL = "SELECT * FROM Prodotto";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Prodotto p = new Prodotto();
                p.setIdProdotto(resultSet.getInt("id_prodotto"));
                p.setNome(resultSet.getString("nome"));
                p.setDescrizione(resultSet.getString("descrizione"));
                p.setPrezzo(resultSet.getDouble("prezzo"));
                p.setQuantitaMagazzino(resultSet.getInt("quantita_magazzino"));
                p.setImmagineUrl(resultSet.getString("immagine_url"));
                p.setFaseUtilizzo(resultSet.getString("fase_utilizzo"));
                p.setIdSottocategoria(resultSet.getInt("id_sottocategoria"));
                p.setTipoCuteTarget(resultSet.getString("tipo_cute_target"));
                p.setTipoCapelloTarget(resultSet.getString("tipo_capello_target"));
                
                prodotti.add(p);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return prodotti;
    }

    //Recupera un singolo prodotto tramite il suo ID
    public synchronized Prodotto doRetrieveById(int idProdotto) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        Prodotto p = null;
        String selectSQL = "SELECT * FROM Prodotto WHERE id_prodotto = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, idProdotto);
            
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                p = new Prodotto();
                p.setIdProdotto(resultSet.getInt("id_prodotto"));
                p.setNome(resultSet.getString("nome"));
                p.setDescrizione(resultSet.getString("descrizione"));
                p.setPrezzo(resultSet.getDouble("prezzo"));
                p.setQuantitaMagazzino(resultSet.getInt("quantita_magazzino"));
                p.setImmagineUrl(resultSet.getString("immagine_url"));
                p.setFaseUtilizzo(resultSet.getString("fase_utilizzo"));
                p.setIdSottocategoria(resultSet.getInt("id_sottocategoria"));p.setTipoCuteTarget(resultSet.getString("tipo_cute_target"));
                p.setTipoCapelloTarget(resultSet.getString("tipo_capello_target"));
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return p; // Restituisce il prodotto trovato (o null se l'ID non esiste)
    }
    
    public synchronized List<Prodotto> doRetrieveRaccomandati(String cute, String capello) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        List<Prodotto> raccomandati = new ArrayList<>();

        // Cerchiamo i prodotti che corrispondono alle esigenze e ne prendiamo solo 3
        String selectSQL = "SELECT * FROM Prodotto WHERE tipo_cute_target = ? AND tipo_capello_target = ? LIMIT 3";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, cute);
            preparedStatement.setString(2, capello);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Prodotto p = new Prodotto();
                raccomandati.add(p);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return raccomandati;
    }
    
 // Recupera i prodotti appartenenti a una macro-categoria passando l'ID della categoria
    public synchronized List<Prodotto> doRetrieveByCategoria(int idCategoria) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Prodotto> prodotti = new ArrayList<>();
        
        // Query SQL con JOIN: prende tutti i prodotti la cui sottocategoria appartiene alla macro-categoria specificata
        String selectSQL = "SELECT p.* FROM Prodotto p " +
                           "JOIN Sottocategoria s ON p.id_sottocategoria = s.id_sottocategoria " +
                           "WHERE s.id_categoria = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, idCategoria);
            
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Prodotto p = new Prodotto();
                p.setIdProdotto(resultSet.getInt("id_prodotto"));
                p.setNome(resultSet.getString("nome"));
                p.setDescrizione(resultSet.getString("descrizione"));
                p.setPrezzo(resultSet.getDouble("prezzo"));
                p.setQuantitaMagazzino(resultSet.getInt("quantita_magazzino"));
                p.setImmagineUrl(resultSet.getString("immagine_url"));
                p.setFaseUtilizzo(resultSet.getString("fase_utilizzo"));
                p.setIdSottocategoria(resultSet.getInt("id_sottocategoria"));
                p.setTipoCuteTarget(resultSet.getString("tipo_cute_target"));
                p.setTipoCapelloTarget(resultSet.getString("tipo_capello_target"));
                
                prodotti.add(p);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return prodotti;
    }
}