package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import models.ModelTelefone;

public class DAOTelefoneRepository {
	
	private Connection connection;

	public DAOTelefoneRepository() {
		connection = SingleConnection.getConnection();
	}
	
	public void save(String numero, Long id) {
		
		try {
			
			String sql = "INSERT INTO model_telefone (numero, usuario_id) VALUES (?, ?)";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, numero);
			statement.setLong(2, id);		
			
			statement.execute();
			connection.commit();
			
		}catch (Exception e) {
			try {
				
				connection.rollback();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}		
	}
	
	public void deleteById(Long id) {
		
		try {
			
			String sql = "DELETE FROM model_telefone WHERE id = ?";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setLong(1, id);
			
			statement.executeUpdate();
			
			connection.commit();
			
		}catch (Exception e) {
			try {
				
				connection.rollback();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}	
		
	}
	
	public List<ModelTelefone> listByUserId(Long id){
		
		DAOLoginRepository userRepo = new DAOLoginRepository();
		
		List<ModelTelefone> listTelefones = new ArrayList<ModelTelefone>();
		
		try {
			
			String sql = "SELECT id, numero FROM model_telefone WHERE usuario_id = ?";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, id);
			ResultSet rs = statement.executeQuery();
			
			while(rs.next()) {
				ModelTelefone telefone = new ModelTelefone();
				
				telefone.setId(rs.getLong("id"));
				telefone.setNumero(rs.getString("numero"));
				telefone.setUsuario(userRepo.searchById(id));
				
				listTelefones.add(telefone);
			}
			
			return listTelefones;
			
		}catch (Exception e) {
			try {
				
				connection.rollback();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
			
			return null;
		}	
		
	}

}
