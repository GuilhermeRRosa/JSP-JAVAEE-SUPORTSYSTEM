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
	private DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();

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

			String sql = "INSERT INTO model_login (nome, email, username, password, perfil, genero, user_image, cep, logradouro, bairro, cidade, uf, empresa) " + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, model.getNome());
			statement.setString(2, model.getEmail());
			statement.setString(3, model.getUser());
			statement.setString(4, model.getPassword());
			statement.setString(5, model.getPerfil());
			statement.setString(6, model.getGenero());
			statement.setString(7, model.getUserImage());
			statement.setString(8, model.getCep());
			statement.setString(9, model.getLogradouro());
			statement.setString(10, model.getBairro());
			statement.setString(11, model.getCidade());
			statement.setString(12, model.getUf());
			statement.setLong(13, model.getEmpresa().getId());
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

			String sql = "SELECT id, nome, email, username, password, perfil, genero, user_image, cep, logradouro, bairro, cidade, uf, empresa FROM model_login WHERE username = ? AND isadmin = false";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			ResultSet set = statement.executeQuery();

			if (set.next()) {
				user.setId(set.getLong("id"));
				user.setNome(set.getString("nome"));
				user.setEmail(set.getString("email"));
				user.setUser(set.getString("username"));
				user.setPassword(set.getString("password"));
				user.setPerfil(set.getString("perfil"));
				user.setGenero(set.getString("genero"));
				user.setUserImage(set.getString("user_image"));
				user.setCep(set.getString("cep"));
				user.setLogradouro(set.getString("logradouro"));
				user.setBairro(set.getString("bairro"));
				user.setCidade(set.getString("cidade"));
				user.setUf(set.getString("uf"));
				user.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
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

			String sql = "SELECT id, nome, email, username, password, perfil, genero, user_image, cep, logradouro, bairro, cidade, uf, empresa FROM model_login WHERE username = ?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			ResultSet set = statement.executeQuery();

			if (set.next()) {
				user.setId(set.getLong("id"));
				user.setNome(set.getString("nome"));
				user.setEmail(set.getString("email"));
				user.setUser(set.getString("username"));
				user.setPassword(set.getString("password"));
				user.setPerfil(set.getString("perfil"));
				user.setGenero(set.getString("genero"));
				user.setUserImage(set.getString("user_image"));
				user.setCep(set.getString("cep"));
				user.setLogradouro(set.getString("logradouro"));
				user.setBairro(set.getString("bairro"));
				user.setCidade(set.getString("cidade"));
				user.setUf(set.getString("uf"));
				user.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
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

			String sql = "SELECT id, nome, email, username, password, genero, user_image, cep, logradouro, bairro, cidade, uf, perfil, empresa FROM model_login WHERE id = ? AND isadmin = false";
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
				user.setUserImage(set.getString("user_image"));
				user.setCep(set.getString("cep"));
				user.setLogradouro(set.getString("logradouro"));
				user.setBairro(set.getString("bairro"));
				user.setCidade(set.getString("cidade"));
				user.setUf(set.getString("uf"));
				user.setPerfil(set.getString("perfil"));
				user.setEmpresa(empresaRepo.findById(set.getLong("empresa")));

			}

			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return user;
		}

	}

	public ModelLogin update(ModelLogin model) {
		try {

			String sql = "UPDATE model_login SET username=?, password=?, nome=?, email=?, perfil=?, genero=?, user_image=?, cep=?, logradouro=?, bairro=?, cidade=?, uf=?, empresa=? WHERE id = ? AND isadmin = false;";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, model.getUser());
			statement.setString(2, model.getPassword());
			statement.setString(3, model.getNome());
			statement.setString(4, model.getEmail());
			statement.setString(5, model.getPerfil());
			statement.setString(6, model.getGenero());
			statement.setString(7, model.getUserImage());
			statement.setString(8, model.getCep());
			statement.setString(9, model.getLogradouro());
			statement.setString(10, model.getBairro());
			statement.setString(11, model.getCidade());
			statement.setString(12, model.getUf());
			statement.setLong(13, model.getEmpresa().getId());
			statement.setLong(14, model.getId());
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

			String sql = "SELECT username, id, nome, email, perfil, genero, user_image, cep, logradouro, bairro, cidade, uf, empresa FROM public.model_login WHERE UPPER(nome) like UPPER(?) AND isadmin = false;";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, "%" + nomeP + "%");
			ResultSet set = statement.executeQuery();

			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setPerfil(set.getString("perfil"));
				dados.setGenero(set.getString("genero"));
				dados.setUserImage(set.getString("user_image"));
				dados.setCep(set.getString("cep"));
				dados.setLogradouro(set.getString("logradouro"));
				dados.setBairro(set.getString("bairro"));
				dados.setCidade(set.getString("cidade"));
				dados.setUf(set.getString("uf"));
				dados.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
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

			String sql = "SELECT username, id, nome, email, perfil, genero, user_image, cep, logradouro, bairro, cidade, uf, empresa FROM model_login WHERE isadmin = false";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet set = statement.executeQuery();

			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setPerfil(set.getString("perfil"));
				dados.setGenero(set.getString("genero"));
				dados.setUserImage(set.getString("user_image"));
				dados.setCep(set.getString("cep"));
				dados.setLogradouro(set.getString("logradouro"));
				dados.setBairro(set.getString("bairro"));
				dados.setCidade(set.getString("cidade"));
				dados.setUf(set.getString("uf"));
				dados.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
				resultUsers.add(dados);
			}

			return resultUsers;

		} catch (Exception e) {
			e.printStackTrace();
			return resultUsers;
		}

	}
	
	public List<ModelLoginDTO> findAllPagination(Integer pagina) {
		
		List<ModelLoginDTO> resultUsers = new ArrayList<>();
		
		int offset = 10;
		
		if(pagina == null) {
			pagina = 1;
		}
			
		try {
			
			String sql = "SELECT username, id, nome, email, perfil, genero, user_image, cep, logradouro, bairro, cidade, uf, empresa FROM model_login WHERE isadmin = false ORDER BY nome ASC offset "+(offset*pagina)+" limit 10";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet set = statement.executeQuery();
			
			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setPerfil(set.getString("perfil"));
				dados.setGenero(set.getString("genero"));
				dados.setUserImage(set.getString("user_image"));
				dados.setCep(set.getString("cep"));
				dados.setLogradouro(set.getString("logradouro"));
				dados.setBairro(set.getString("bairro"));
				dados.setCidade(set.getString("cidade"));
				dados.setUf(set.getString("uf"));
				dados.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
				resultUsers.add(dados);
			}
			
			return resultUsers;
			
		} catch (Exception e) {
			e.printStackTrace();
			return resultUsers;
		}
		
	}
	
	public int countPaginas() {
		
		Double totalPaginas = (double) countUsers() / 10;

		if (((double) countUsers() % 10) > 0) {
			totalPaginas += 1;
		}
		
		return totalPaginas.intValue();
	}
	
	public int countUsers() {
		
		Integer result = 0;
		
		try {
			
		String sql = "select count(1) as conta from model_login where isadmin=false";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet set = statement.executeQuery();
		
		set.next();
		
		result = set.getInt("conta");
		
		return result;
			
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}
	}
	
	public int countPaginas(Long empresaResp) {
		
		Double totalPaginas = (double) countUsers(empresaResp) / 10;

		if (((double) countUsers(empresaResp) % 10) > 0) {
			totalPaginas += 1;
		}
		
		return totalPaginas.intValue();
	}
	
	public int countUsers(Long empresaResp) {
		
		Integer result = 0;
		
		try {
	
		String sql = " SELECT count(1) as conta "
				+" FROM model_login ml, model_empresa me WHERE isadmin = false AND me.empresa_resp = ? AND ml.empresa = me.id "
				+" UNION "
				+" SELECT count(1) as conta "
				+" FROM model_login ml, model_empresa me WHERE isadmin = false AND ml.empresa = ? ";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, empresaResp);
		statement.setLong(2, empresaResp);
		ResultSet set = statement.executeQuery();
		
		set.next();
		
		result = set.getInt("conta");
		
		return result;
			
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}
	}

	public List<ModelLoginDTO> findAllByEmpresaResp(Integer pagina, Long empresaResp) {
		List<ModelLoginDTO> resultUsers = new ArrayList<>();
		
		int offset = 10;
		
		if(pagina == null) {
			pagina = 1;
		}
			
		try {
			
			String sql = " SELECT ml.username, ml.id, ml.nome, ml.email, ml.perfil, ml.genero, ml.user_image, ml.cep, ml.logradouro, ml.bairro, ml.cidade, ml.uf, ml.empresa "
						+" FROM model_login ml, model_empresa me WHERE isadmin = false AND me.empresa_resp = ? AND ml.empresa = me.id "
						+" UNION "
						+" SELECT ml.username, ml.id, ml.nome, ml.email, ml.perfil, ml.genero, ml.user_image, ml.cep, ml.logradouro, ml.bairro, ml.cidade, ml.uf, ml.empresa "
						+" FROM model_login ml, model_empresa me WHERE isadmin = false AND ml.empresa = ? ORDER BY nome ASC offset "+(offset*pagina)+" limit 10";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, empresaResp);
			statement.setLong(2, empresaResp);
			ResultSet set = statement.executeQuery();
			
			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setPerfil(set.getString("perfil"));
				dados.setGenero(set.getString("genero"));
				dados.setUserImage(set.getString("user_image"));
				dados.setCep(set.getString("cep"));
				dados.setLogradouro(set.getString("logradouro"));
				dados.setBairro(set.getString("bairro"));
				dados.setCidade(set.getString("cidade"));
				dados.setUf(set.getString("uf"));
				dados.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
				resultUsers.add(dados);
			}
			
			return resultUsers;
			
		} catch (Exception e) {
			e.printStackTrace();
			return resultUsers;
		}
	}

	public List<ModelLoginDTO> findByName(String nomeP, Long empresaResp) {
		
		List<ModelLoginDTO> resultUsers = new ArrayList<>();

		try {

			String sql = " SELECT ml.username, ml.id, ml.nome, ml.email, ml.perfil, ml.genero, ml.user_image, ml.cep, ml.logradouro, ml.bairro, ml.cidade, ml.uf, ml.empresa "
					+" FROM model_login ml, model_empresa me WHERE ml.isadmin = false AND me.empresa_resp = ? AND ml.empresa = me.id "
					+" UNION "
					+" SELECT ml.username, ml.id, ml.nome, ml.email, ml.perfil, ml.genero, ml.user_image, ml.cep, ml.logradouro, ml.bairro, ml.cidade, ml.uf, ml.empresa "
					+" FROM model_login ml, model_empresa me WHERE ml.isadmin = false AND ml.empresa = ? AND UPPER(ml.nome) like UPPER(?) ORDER BY nome ASC";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, empresaResp);
			statement.setLong(2, empresaResp);
			statement.setString(3, "%" + nomeP + "%");
			ResultSet set = statement.executeQuery();

			while (set.next()) {
				ModelLoginDTO dados = new ModelLoginDTO();
				dados.setId(set.getLong("id"));
				dados.setNome(set.getString("nome"));
				dados.setUser(set.getString("username"));
				dados.setEmail(set.getString("email"));
				dados.setPerfil(set.getString("perfil"));
				dados.setGenero(set.getString("genero"));
				dados.setUserImage(set.getString("user_image"));
				dados.setCep(set.getString("cep"));
				dados.setLogradouro(set.getString("logradouro"));
				dados.setBairro(set.getString("bairro"));
				dados.setCidade(set.getString("cidade"));
				dados.setUf(set.getString("uf"));
				dados.setEmpresa(empresaRepo.findById(set.getLong("empresa")));
				resultUsers.add(dados);
			}

			return resultUsers;

		} catch (Exception e) {
			e.printStackTrace();
			return resultUsers;
		}
	}
}
