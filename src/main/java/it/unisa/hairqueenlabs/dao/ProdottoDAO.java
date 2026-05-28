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
                p.setNovita(resultSet.getBoolean("is_novita"));
                
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
        String selectSQL = "SELECT * FROM Prodotto WHERE (tipo_cute_target = ? OR tipo_cute_target = 'Tutti') AND (tipo_capello_target = ? OR tipo_capello_target = 'Tutti')";
        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, cute);
            preparedStatement.setString(2, capello);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Prodotto p = new Prodotto();
                //Riempiamo l'oggetto con i dati reali del DB
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
    
 // Recupera i prodotti filtrati per Sottocategoria
    public synchronized List<Prodotto> doRetrieveBySottocategoria(int idSottocategoria) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        List<Prodotto> prodotti = new ArrayList<>();
        String selectSQL = "SELECT * FROM Prodotto WHERE id_sottocategoria = ?";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, idSottocategoria);
            
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
    
    // Inserimento di un nuovo prodotto nel database (Area Amministratore)
    public synchronized void doSave(Prodotto prodotto) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO Prodotto (nome, descrizione, prezzo, quantita_magazzino, "
                + "immagine_url, fase_utilizzo, id_sottocategoria, tipo_cute_target, tipo_capello_target) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);

            preparedStatement.setString(1, prodotto.getNome());
            preparedStatement.setString(2, prodotto.getDescrizione());
            preparedStatement.setDouble(3, prodotto.getPrezzo());
            preparedStatement.setInt(4, prodotto.getQuantitaMagazzino());
            preparedStatement.setString(5, prodotto.getImmagineUrl());
            preparedStatement.setString(6, prodotto.getFaseUtilizzo());

            if (prodotto.getIdSottocategoria() > 0) {
                preparedStatement.setInt(7, prodotto.getIdSottocategoria());
            } else {
                preparedStatement.setNull(7, java.sql.Types.INTEGER);
            }
            
            preparedStatement.setString(8, prodotto.getTipoCuteTarget());
            preparedStatement.setString(9, prodotto.getTipoCapelloTarget());

            preparedStatement.executeUpdate();

            connection.commit();

        } finally {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) DriverManagerConnectionPool.releaseConnection(connection);
        }
    }
    
    public List<Prodotto> doRetrieveNovita() {
        List<Prodotto> prodotti = new ArrayList<>();
        String query = "SELECT * FROM Prodotto WHERE is_novita = 1";

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setIdProdotto(rs.getInt("id_prodotto"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setQuantitaMagazzino(rs.getInt("quantita_magazzino"));
                p.setImmagineUrl(rs.getString("immagine_url"));
                p.setFaseUtilizzo(rs.getString("fase_utilizzo"));
                p.setIdSottocategoria(rs.getInt("id_sottocategoria"));
                p.setTipoCuteTarget(rs.getString("tipo_cute_target"));
                p.setTipoCapelloTarget(rs.getString("tipo_capello_target"));
                p.setNovita(rs.getBoolean("is_novita")); 

                prodotti.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prodotti;
    }
}