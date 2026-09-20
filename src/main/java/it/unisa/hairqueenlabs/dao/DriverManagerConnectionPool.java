package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DriverManagerConnectionPool {

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            
            ds = (DataSource) envCtx.lookup("jdbc/hairqueen");
            
        } catch (NamingException e) {
            System.out.println("Errore JNDI durante l'inizializzazione del DataSource: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        if (ds == null) {
            throw new SQLException("DataSource non inizializzato. Controlla il context.xml in META-INF.");
        }
        return ds.getConnection();
    }

    public static void releaseConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close(); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}