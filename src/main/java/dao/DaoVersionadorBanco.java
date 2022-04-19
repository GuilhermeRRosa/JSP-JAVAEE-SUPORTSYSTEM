package dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import connection.SingleConnection;

public class DaoVersionadorBanco implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Connection connection;

	public DaoVersionadorBanco() {
		connection = SingleConnection.getConnection();
	}
	
	public void gravaArquivoSqlRodado(String nome_file) throws Exception{
		String sql = "INSERT INTO versionadorbanco(arquivo_sql) VALUES (?);";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, nome_file);
		statement.execute();
	}
	
	public boolean arquivoSqlRodado(String arquivoSql) throws Exception {
		String sql = "select count(1) > 0 as rodado from versionadorbanco where arquivo_sql = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, arquivoSql);
			ResultSet rs = preparedStatement.executeQuery();
			rs.next();
			return rs.getBoolean("rodado");
		} catch (Exception e) {
			e.printStackTrace();
			connection.rollback();
		}
		return false;
	}

}
