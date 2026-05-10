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
                p.setIdSottocategoria(resultSet.getInt("id_sottocategoria"));
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return p; // Restituisce il prodotto trovato (o null se l'ID non esiste)
    }
}