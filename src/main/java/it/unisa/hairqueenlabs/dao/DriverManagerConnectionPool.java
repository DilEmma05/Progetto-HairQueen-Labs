package it.unisa.hairqueenlabs.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class DriverManagerConnectionPool {

	private static List<Connection> freeConnections;

	static {
		freeConnections = new LinkedList<Connection>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver non trovato: " + e.getMessage());
		}
	}

	private static synchronized Connection createDBConnection() throws SQLException {
		Connection newConnection = null;
		String ip = "localhost";
		String port = "3306";
		String dbName = "HairQueen_Labs";
		String username = "root";
		String password = "Trimon0405.,";

		newConnection = DriverManager.getConnection("jdbc:mysql://" + ip + ":" + port + "/" + dbName, username, password);
		newConnection.setAutoCommit(false);
		return newConnection;
	}

	public static synchronized Connection getConnection() throws SQLException {
		Connection connection;

		if (!freeConnections.isEmpty()) {
			connection = (Connection) freeConnections.get(0);
			freeConnections.remove(0);

			try {
				if (connection.isClosed())
					connection = getConnection();
			} catch (SQLException e) {
				connection.isClosed();
				connection = getConnection();
			}
		} else {
			connection = createDBConnection();
		}

		return connection;
	}

	public static synchronized void releaseConnection(Connection connection) throws SQLException {
		if (connection != null) {
			freeConnections.add(connection);
		}
	}
}