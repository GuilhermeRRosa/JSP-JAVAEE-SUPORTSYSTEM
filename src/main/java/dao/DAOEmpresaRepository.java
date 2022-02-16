package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import models.ModelEmpresa;

public class DAOEmpresaRepository {

	private Connection connection;
	
	public DAOEmpresaRepository(){
		connection = SingleConnection.getConnection();
	}
	
	public ModelEmpresa save(ModelEmpresa empresa, Long empresaResp) {
		try {
			
			String sql = " INSERT INTO public.model_empresa "+
						" (cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil, empresa_resp) "+
						" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); ";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, empresa.getCnpj());
			statement.setString(2, empresa.getRazaoSocial());
			statement.setString(3, empresa.getCep());
			statement.setString(4, empresa.getLogradouro());
			statement.setString(5, empresa.getBairro());
			statement.setString(6, empresa.getCidade());
			statement.setString(7, empresa.getUf());
			statement.setString(8, empresa.getTelefone());
			statement.setString(9, empresa.getRamo());
			statement.setString(10, empresa.getEmail());
			statement.setLong(11, empresa.getRepresentante().getId());
			statement.setString(12, empresa.getLogo());
			statement.setString(13, empresa.getPerfil());	
			statement.setLong(14, empresaResp);	
			
			statement.execute();
			
			connection.commit();	
			
			return findByCnpj(empresa.getCnpj());
			
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
				return null;
			}
			e.printStackTrace();
			return null;
		}
	}
	
	public ModelEmpresa findByCnpj(String cnpj) {
		
		try {
			
			DAOLoginRepository userRepo = new DAOLoginRepository();
			ModelEmpresa empresa = new ModelEmpresa();
			
			String sql = " SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil "
					+ "	FROM public.model_empresa WHERE cnpj = ?;";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, cnpj);
			
			ResultSet set = statement.executeQuery();
			
			if(set.next()) {
				empresa.setId(set.getLong("id"));
				empresa.setCnpj(set.getString("cnpj"));
				empresa.setRazaoSocial(set.getString("razao_social"));
				empresa.setCep(set.getString("cep"));
				empresa.setLogradouro(set.getString("logradouro"));
				empresa.setBairro(set.getString("bairro"));
				empresa.setCidade(set.getString("cidade"));
				empresa.setUf(set.getString("uf"));
				empresa.setTelefone(set.getString("telefone"));
				empresa.setRamo(set.getString("ramo"));
				empresa.setEmail(set.getString("email"));
				empresa.setRepresentante(userRepo.searchById(set.getLong("representante")));
				empresa.setLogo(set.getString("logo"));
				empresa.setPerfil(set.getString("perfil"));		
			}		
			return empresa;
		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	public List<ModelEmpresa> findByRazaoSocial(String razaoSocial){	
		
		try {		
			List<ModelEmpresa> empresas = new ArrayList<ModelEmpresa>();
			DAOLoginRepository userRepo = new DAOLoginRepository();
		
			String sql = " SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil "
					+ "	FROM public.model_empresa WHERE UPPER(razao_social) like UPPER(?)";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, "%"+razaoSocial+"%");
			
			ResultSet set = statement.executeQuery();
			
			while(set.next()) {
				ModelEmpresa empresa = new ModelEmpresa();
				empresa.setId(set.getLong("id"));
				empresa.setCnpj(set.getString("cnpj"));
				empresa.setRazaoSocial(set.getString("razao_social"));
				empresa.setCep(set.getString("cep"));
				empresa.setLogradouro(set.getString("logradouro"));
				empresa.setBairro(set.getString("bairro"));
				empresa.setCidade(set.getString("cidade"));
				empresa.setUf(set.getString("uf"));
				empresa.setTelefone(set.getString("telefone"));
				empresa.setRamo(set.getString("ramo"));
				empresa.setEmail(set.getString("email"));
				empresa.setRepresentante(userRepo.searchById(set.getLong("representante")));
				empresa.setLogo(set.getString("logo"));
				empresa.setPerfil(set.getString("perfil"));		
				empresas.add(empresa);
			}		
			return empresas;
		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
		
	}

	public void deleteById(Long id) {
		
		try {
			
			String sql = "DELETE FROM model_empresa WHERE id = ?";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, id);	
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
	
	public List<ModelEmpresa> findAllPagination(Integer pagina) {
		
		List<ModelEmpresa> resultEmpresa = new ArrayList<>();	
		DAOLoginRepository userRepo = new DAOLoginRepository();
		
		int offset = 10;
		
		if(pagina == null) {
			pagina = 1;
		}
			
		try {
			
			String sql = " SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil "
						+" FROM model_empresa ORDER BY razao_social ASC offset "+(offset*pagina)+" limit 10";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet set = statement.executeQuery();
			
			while (set.next()) {
				ModelEmpresa empresa = new ModelEmpresa();
				empresa.setId(set.getLong("id"));
				empresa.setCnpj(set.getString("cnpj"));
				empresa.setRazaoSocial(set.getString("razao_social"));
				empresa.setCep(set.getString("cep"));
				empresa.setLogradouro(set.getString("logradouro"));
				empresa.setBairro(set.getString("bairro"));
				empresa.setCidade(set.getString("cidade"));
				empresa.setUf(set.getString("uf"));
				empresa.setTelefone(set.getString("telefone"));
				empresa.setRamo(set.getString("ramo"));
				empresa.setEmail(set.getString("email"));
				
				empresa.setRepresentante(userRepo.searchById(set.getLong("representante")));
				empresa.setLogo(set.getString("logo"));
				empresa.setPerfil(set.getString("perfil"));		
				resultEmpresa.add(empresa);
			}
			
			return resultEmpresa;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public int countPaginas() {
		
		Double totalPaginas = (double) countUsers() / 10;

		if (((double) countUsers() % 10) > 0) {
			totalPaginas += 1;
		}
		
		return totalPaginas.intValue();
	}
	
	public int countPaginasByPerfil(Long empresaResp) {
		
		Double totalPaginas = (double) countUsersByPerfil(empresaResp) / 10;

		if (((double) countUsersByPerfil(empresaResp) % 10) > 0) {
			totalPaginas += 1;
		}
		
		return totalPaginas.intValue();
	}
	
	public int countUsers() {
		
		Integer result = 0;
		
		try {
			
		String sql = "select count(1) as conta from model_empresa";
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
	
	public int countUsersByPerfil(Long empresaResp) {
		
		Integer result = 0;
		
		try {
			
		String sql = "select count(1) as conta from model_empresa WHERE empresa_resp = ?";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, empresaResp);
		ResultSet set = statement.executeQuery();
		
		set.next();
		
		result = set.getInt("conta");
		
		return result;
			
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}
	}

	public ModelEmpresa findById(Long id) {
		
		try {
			
			DAOLoginRepository userRepo = new DAOLoginRepository();
			ModelEmpresa empresa = new ModelEmpresa();
			
			String sql = " SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil "
					+ "	FROM public.model_empresa WHERE id = ?;";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setLong(1, id);
			
			ResultSet set = statement.executeQuery();
			
			if(set.next()) {
				empresa.setId(set.getLong("id"));
				empresa.setCnpj(set.getString("cnpj"));
				empresa.setRazaoSocial(set.getString("razao_social"));
				empresa.setCep(set.getString("cep"));
				empresa.setLogradouro(set.getString("logradouro"));
				empresa.setBairro(set.getString("bairro"));
				empresa.setCidade(set.getString("cidade"));
				empresa.setUf(set.getString("uf"));
				empresa.setTelefone(set.getString("telefone"));
				empresa.setRamo(set.getString("ramo"));
				empresa.setEmail(set.getString("email"));			
				empresa.setLogo(set.getString("logo"));
				empresa.setPerfil(set.getString("perfil"));	
				empresa.setRepresentante(userRepo.searchById(set.getLong("representante")));	 
			}		
			return empresa;
		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ModelEmpresa update(ModelEmpresa empresa, Long empresaResp) {
		
		try {
			
			String sql = " UPDATE public.model_empresa SET "+
						" cnpj=?, razao_social=?, cep=?, logradouro=?, bairro=?, cidade=?, uf=?, telefone=?, ramo=?, email=?, representante=?, logo=?, perfil=?, empresa_resp=? "+
						" WHERE id = ? ";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, empresa.getCnpj());
			statement.setString(2, empresa.getRazaoSocial());
			statement.setString(3, empresa.getCep());
			statement.setString(4, empresa.getLogradouro());
			statement.setString(5, empresa.getBairro());
			statement.setString(6, empresa.getCidade());
			statement.setString(7, empresa.getUf());
			statement.setString(8, empresa.getTelefone());
			statement.setString(9, empresa.getRamo());
			statement.setString(10, empresa.getEmail());
			statement.setLong(11, empresa.getRepresentante().getId());
			statement.setString(12, empresa.getLogo());
			statement.setString(13, empresa.getPerfil());	
			statement.setLong(14, empresaResp);	
			statement.setLong(15, empresa.getId());	
			
			statement.execute();
			
			connection.commit();	
			
			return findByCnpj(empresa.getCnpj());
			
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
				return null;
			}
			e.printStackTrace();
			return null;
		}
	}

	public List<ModelEmpresa> findAllPaginationByPerfil(Integer pagina, Long empresaResp) {
		List<ModelEmpresa> resultEmpresa = new ArrayList<>();	
		DAOLoginRepository userRepo = new DAOLoginRepository();
		
		int offset = 10;
		
		if(pagina == null) {
			pagina = 1;
		}
			
		try {
			
			String sql = " SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil "
						+" FROM model_empresa WHERE empresa_resp = ? ORDER BY razao_social ASC offset "+(offset*pagina)+" limit 10";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, empresaResp);
			ResultSet set = statement.executeQuery();
			
			while (set.next()) {
				ModelEmpresa empresa = new ModelEmpresa();
				empresa.setId(set.getLong("id"));
				empresa.setCnpj(set.getString("cnpj"));
				empresa.setRazaoSocial(set.getString("razao_social"));
				empresa.setCep(set.getString("cep"));
				empresa.setLogradouro(set.getString("logradouro"));
				empresa.setBairro(set.getString("bairro"));
				empresa.setCidade(set.getString("cidade"));
				empresa.setUf(set.getString("uf"));
				empresa.setTelefone(set.getString("telefone"));
				empresa.setRamo(set.getString("ramo"));
				empresa.setEmail(set.getString("email"));	
				empresa.setRepresentante(userRepo.searchById(set.getLong("representante")));
				empresa.setLogo(set.getString("logo"));
				empresa.setPerfil(set.getString("perfil"));		
				resultEmpresa.add(empresa);
			}
			
			return resultEmpresa;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<ModelEmpresa> findByRazaoSocial(String razaoSocial, Long empresaResp) {
		
		try {		
			List<ModelEmpresa> empresas = new ArrayList<ModelEmpresa>();
			DAOLoginRepository userRepo = new DAOLoginRepository();
		
			String sql = " SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil "
					+ "	FROM public.model_empresa WHERE UPPER(razao_social) like UPPER(?) AND empresa_resp = ?";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, "%"+razaoSocial+"%");
			statement.setLong(2, empresaResp);
			
			ResultSet set = statement.executeQuery();
			
			while(set.next()) {
				ModelEmpresa empresa = new ModelEmpresa();
				empresa.setId(set.getLong("id"));
				empresa.setCnpj(set.getString("cnpj"));
				empresa.setRazaoSocial(set.getString("razao_social"));
				empresa.setCep(set.getString("cep"));
				empresa.setLogradouro(set.getString("logradouro"));
				empresa.setBairro(set.getString("bairro"));
				empresa.setCidade(set.getString("cidade"));
				empresa.setUf(set.getString("uf"));
				empresa.setTelefone(set.getString("telefone"));
				empresa.setRamo(set.getString("ramo"));
				empresa.setEmail(set.getString("email"));
				empresa.setRepresentante(userRepo.searchById(set.getLong("representante")));
				empresa.setLogo(set.getString("logo"));
				empresa.setPerfil(set.getString("perfil"));		
				empresas.add(empresa);
			}		
			return empresas;
		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
	}

	public ModelEmpresa findEmpresaResp(Long empresaCliente) {
		
		try {
			
			DAOLoginRepository userRepo = new DAOLoginRepository();
			
			String sql = "SELECT id, cnpj, razao_social, cep, logradouro, bairro, cidade, uf, telefone, ramo, email, representante, logo, perfil, empresa_resp "
					+ "	FROM public.model_empresa WHERE id = (SELECT empresa_resp from public.model_empresa WHERE id = ?);";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, empresaCliente);
			ResultSet rs = statement.executeQuery();
			
			if(rs.next()) {
				ModelEmpresa empresa = new ModelEmpresa();
				empresa.setId(rs.getLong("id"));
				empresa.setCnpj(rs.getString("cnpj"));
				empresa.setRazaoSocial(rs.getString("razao_social"));
				empresa.setCep(rs.getString("cep"));
				empresa.setLogradouro(rs.getString("logradouro"));
				empresa.setBairro(rs.getString("bairro"));
				empresa.setCidade(rs.getString("cidade"));
				empresa.setUf(rs.getString("uf"));
				empresa.setTelefone(rs.getString("telefone"));
				empresa.setRamo(rs.getString("ramo"));
				empresa.setEmail(rs.getString("email"));
				empresa.setRepresentante(userRepo.searchById(rs.getLong("representante")));
				empresa.setLogo(rs.getString("logo"));
				empresa.setPerfil(rs.getString("perfil"));
				return empresa;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
}
