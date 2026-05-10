package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import it.unisa.hairqueenlabs.model.Utente;

public class UtenteDAO {

    // Registrazione utente nel database
    public synchronized void doSave(Utente utente) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO Utente (nome, cognome, email, password, indirizzo, ruolo) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);

            preparedStatement.setString(1, utente.getNome());
            preparedStatement.setString(2, utente.getCognome());
            preparedStatement.setString(3, utente.getEmail());
            preparedStatement.setString(4, utente.getPassword());
            preparedStatement.setString(5, utente.getIndirizzo());
            preparedStatement.setString(6, utente.getRuolo());

            preparedStatement.executeUpdate();
            connection.commit();

        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
    }

    // Recupera tutti gli utenti dal database
    public synchronized List<Utente> doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Utente> utenti = new ArrayList<>();
        String selectSQL = "SELECT * FROM Utente";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Utente u = new Utente();
                u.setIdUtente(resultSet.getInt("id_utente"));
                u.setNome(resultSet.getString("nome"));
                u.setNome(resultSet.getString("nome"));
                u.setCognome(resultSet.getString("cognome"));
                u.setEmail(resultSet.getString("email"));
                u.setPassword(resultSet.getString("password"));
                u.setIndirizzo(resultSet.getString("indirizzo"));
                u.setRuolo(resultSet.getString("ruolo"));
                utenti.add(u);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return utenti;
    }
}