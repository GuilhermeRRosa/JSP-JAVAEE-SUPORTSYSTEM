package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnection{

	private static String url = "jdbc:postgresql://localhost:5432/projetojsp";
	private static String user = "postgres";
	private static String password = "root";
	private static Connection connection = null;

	static {
		connect();
	}

	public SingleConnection() {
		connect();
	}

	public static void connect() {

		try {

			if(connection==null) {
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(url, user, password);
				connection.setAutoCommit(false);
				System.out.println("Conexão realizada");
			}else {
				System.out.println(connection.toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static Connection getConnection() {
		return connection;
	}

}
