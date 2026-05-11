package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import it.unisa.hairqueenlabs.model.Recensione;

public class RecensioneDAO {

    // 1. Inserisce una nuova recensione nel database
    public synchronized void doSave(Recensione recensione) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO Recensione (voto, testo, id_utente, id_prodotto) VALUES (?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);

            preparedStatement.setInt(1, recensione.getVoto());
            preparedStatement.setString(2, recensione.getTesto());
            preparedStatement.setInt(3, recensione.getIdUtente());
            preparedStatement.setInt(4, recensione.getIdProdotto());

            preparedStatement.executeUpdate();
            connection.commit();

        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
    }

    // 2. Recupera tutte le recensioni di un prodotto specifico
    public synchronized List<Recensione> doRetrieveByProdotto(int idProdotto) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Recensione> recensioni = new ArrayList<>();
        String selectSQL = "SELECT * FROM Recensione WHERE id_prodotto = ? ORDER BY data_recensione DESC";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, idProdotto);
            
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Recensione r = new Recensione();
                r.setIdRecensione(resultSet.getInt("id_recensione"));
                r.setVoto(resultSet.getInt("voto"));
                r.setTesto(resultSet.getString("testo"));
                r.setDataRecensione(resultSet.getTimestamp("data_recensione"));
                r.setIdUtente(resultSet.getInt("id_utente"));
                r.setIdProdotto(resultSet.getInt("id_prodotto"));
                
                recensioni.add(r);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return recensioni;
    }
}