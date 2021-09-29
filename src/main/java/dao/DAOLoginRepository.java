package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import dto.ModelLoginDTO;
import models.ModelLogin;

public class DAOLoginRepository {

	private Connection connection;

	public DAOLoginRepository() {
		connection = SingleConnection.getConnection();
	}

	// METODO DAO DE AUTENTICAÇÃO DE USUARIO E SENHA NO BANCO
	public boolean authLogin(ModelLogin modelLogin) {

		try {
			String sql = "SELECT * FROM model_login AS ml WHERE ml.username = ? AND ml.password = ?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, modelLogin.getUser());
			statement.setString(2, modelLogin.getPassword());

			ResultSet set = statement.executeQuery();

			if (set.next()) {
				return true;
			}

			return false;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ModelLogin save(ModelLogin model) {

		try {

			String sql = "INSERT INTO model_login (nome, email, username, password, isadmin, genero) " + " VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, model.getNome());
			statement.setString(2, model.getEmail());
			statement.setString(3, model.getUser());
			statement.setString(4, model.getPassword());
			statement.setBoolean(5, model.isAdmin());
			statement.setString(6, model.getGenero());
			statement.execute();
			connection.commit();

			return this.searchByUser(model.getUser());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ModelLogin searchByUser(String username) {

		ModelLogin user = new ModelLogin();

		try {

			String sql = "SELECT id, nome, email, username, password, isadmin, genero FROM model_login WHERE username = ? AND isadmin = false";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			ResultSet set = statement.executeQuery();

			if (set.next()) {
				user.setId(set.getLong("id"));
				user.setNome(set.getString("nome"));
				user.setEmail(set.getString("email"));
				user.setUser(set.getString("username"));
				user.setPassword(set.getString("password"));
				user.setAdmin(set.getBoolean("isadmin"));
				user.setGenero(set.getString("genero"));
			}

			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return user;
		}

	}

	public ModelLogin getUserByUsername(String username) {

		ModelLogin user = new ModelLogin();

		try {

			String sql = "SELECT id, nome, email, username, password, isadmin, genero FROM model_login WHERE username = ?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			ResultSet set = statement.executeQuery();

			if (set.next()) {
				user.setId(set.getLong("id"));
				user.setNome(set.getString("nome"));
				user.setEmail(set.getString("email"));
				user.setUser(set.getString("username"));
				user.setPassword(set.getString("password"));
				user.setAdmin(set.getBoolean("isadmin"));
				user.setGenero(set.getString("genero"));
			}

			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return user;
		}

	}

	public ModelLogin searchById(Long id) {

		ModelLogin user = new ModelLogin();

		try {

			String sql = "SELECT id, nome, email, username, password, genero FROM model_login WHERE id = ? AND isadmin = false";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, id);
			ResultSet set = statement.executeQuery();

			if (set.next()) {
				user.setId(set.getLong("id"));
				user.setNome(set.getString("nome"));
				user.setEmail(set.getString("email"));
				user.setUser(set.getString("username"));
				user.setPassword(set.getString("password"));
				user.setGenero(set.getString("genero"));
			}

			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return user;
		}

	}

	public ModelLogin update(ModelLogin model) {
		try {

			String sql = "UPDATE model_login SET username=?, password=?, nome=?, email=?, isadmin=?, genero=? WHERE id = ? AND isadmin = false;";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, model.getUser());
			statement.setString(2, model.getPassword());
			statement.setString(3, model.getNome());
			statement.setString(4, model.getEmail());
			statement.setBoolean(5, model.isAdmin());
			statement.setString(6, model.getGenero());
			statement.setLong(7, model.getId());
			statement.executeUpdate();
			connection.commit();

			return this.searchByUser(model.getUser());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean verifyUsername(String username) {

		try {

			String sql = "select count(1) > 0 as existe from model_login where username = '" + username + "';";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet set = statement.executeQuery();

			set.next();
			return set.getBoolean("existe");

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	public void deleteById(Long id) {

		try {

			String sql = "DELETE FROM model_login WHERE id =" + id+" AND isadmin = false";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.executeUpdate();
			connection.commit();

		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}

	}

	public List<ModelLoginDTO> findByName(String nomeP) {

		List<ModelLoginDTO> resultUsers = new ArrayList<>();

		try {

			String sql = "SELECT username, id, nome, email, isadmin, genero FROM public.model_login WHERE UPPER(nome) like UPPER(?) AND isadmin = false;";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, "%" + nomeP + "%");
			ResultSet set = statement.executeQuery();

			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setAdmin(set.getBoolean("isadmin"));
				dados.setGenero(set.getString("genero"));
				resultUsers.add(dados);
			}

			return resultUsers;

		} catch (Exception e) {
			e.printStackTrace();
			return resultUsers;
		}

	}

	public List<ModelLoginDTO> findAll() {

		List<ModelLoginDTO> resultUsers = new ArrayList<>();

		try {

			String sql = "SELECT username, id, nome, email, isadmin, genero FROM model_login WHERE isadmin = false";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet set = statement.executeQuery();

			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setAdmin(set.getBoolean("isadmin"));
				dados.setGenero(set.getString("genero"));
				resultUsers.add(dados);
			}

			return resultUsers;

		} catch (Exception e) {
			e.printStackTrace();
			return resultUsers;
		}

	}
}
