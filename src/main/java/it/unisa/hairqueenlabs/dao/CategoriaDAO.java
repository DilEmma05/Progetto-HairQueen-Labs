package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import it.unisa.hairqueenlabs.model.Categoria;
import it.unisa.hairqueenlabs.model.Sottocategoria;

public class CategoriaDAO {

    public synchronized List<Categoria> doRetrieveAllCategorie() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Categoria> categorie = new ArrayList<>();
        String selectSQL = "SELECT * FROM Categoria";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Categoria c = new Categoria();
                c.setIdCategoria(resultSet.getInt("id_categoria"));
                c.setNomeCategoria(resultSet.getString("nome_categoria"));
                categorie.add(c);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return categorie;
    }

    //Recupera le Sottocategorie collegate a una Categoria specifica
    public synchronized List<Sottocategoria> doRetrieveSottocategorie(int idCategoria) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Sottocategoria> sottocategorie = new ArrayList<>();
        // Cerchiamo solo le sottocategorie che appartengono alla categoria passata
        String selectSQL = "SELECT * FROM Sottocategoria WHERE id_categoria = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, idCategoria);
            
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Sottocategoria s = new Sottocategoria();
                s.setIdSottocategoria(resultSet.getInt("id_sottocategoria"));
                s.setNomeSottocategoria(resultSet.getString("nome_sottocategoria"));
                s.setIdCategoria(resultSet.getInt("id_categoria"));
                sottocategorie.add(s);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return sottocategorie;
    }
}