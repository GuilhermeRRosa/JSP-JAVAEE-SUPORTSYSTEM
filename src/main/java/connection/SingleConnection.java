package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnection{

	private static String url = "jdbc:postgresql://ec2-3-217-113-25.compute-1.amazonaws.com:5432/db6b89gha0b7m3";
	private static String user = "lvzvcnwplwwzjo";
	private static String password = "967d7893c2e08af80858ac594497a3b8bf1c775abf6b81388a67f57c2748c3c7";
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
