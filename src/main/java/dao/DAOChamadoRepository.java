package dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import models.ModelChamado;
import models.ModelLogin;

public class DAOChamadoRepository implements Serializable{

	private static final long serialVersionUID = 1L;

	private Connection connection;
	
	public DAOChamadoRepository() {
		this.connection = SingleConnection.getConnection();
	}
	
	public void save(ModelChamado chamado) {
		try {
			
			String sql = "INSERT INTO public.model_chamado( "
					+ "	cliente, empresa_cliente, empresa_resp, criado_em, titulo, descricao, status) "
					+ "	VALUES (?, ?, ?, ?, ?, ?, ?); ";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, chamado.getCliente().getId());
			statement.setLong(2, chamado.getEmpresaCliente().getId());
			statement.setLong(3, chamado.getEmpresaResp().getId());
			statement.setTimestamp(4, Timestamp.valueOf(chamado.getCriadoEm()));
			statement.setString(5, chamado.getTitulo());
			statement.setString(6, chamado.getDescricao());
			statement.setString(7, chamado.getStatus());
			
			statement.execute();
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

	public List<ModelChamado> findAllByCliente(Long userId, String status) {
		
		List<ModelChamado> chamados = new ArrayList<ModelChamado>();
		DAOLoginRepository userRepo = new DAOLoginRepository();
		DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
		
		try {
			
			String sql = "SELECT id, cliente, empresa_cliente, empresa_resp, criado_em, titulo, status, atendido_por, fechado_por, finalizado_em "
					+ "	FROM public.model_chamado WHERE cliente = ? AND status = ?;";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, userId);
			statement.setString(2, status);
			ResultSet rs = statement.executeQuery();
			
			while(rs.next()) {
				ModelChamado chamado = new ModelChamado();
				chamado.setId(rs.getLong("id"));
				chamado.setCliente(userRepo.searchById(rs.getLong("cliente")));
				chamado.setEmpresaCliente(empresaRepo.findById(rs.getLong("empresa_cliente")));
				chamado.setEmpresaResp(empresaRepo.findById(rs.getLong("empresa_resp")));
				Timestamp c = rs.getTimestamp("criado_em");
				chamado.setCriadoEm(c !=null ? c.toLocalDateTime() : null);
				chamado.setTitulo(rs.getString("titulo"));
				chamado.setStatus(rs.getString("status"));
				chamado.setAtentidoPor(userRepo.searchById(rs.getLong("atendido_por")));
				chamado.setFinalizadoPor(userRepo.searchById(rs.getLong("fechado_por")));
				Timestamp f = rs.getTimestamp("finalizado_em");
				chamado.setFinalizadoEm(f !=null ? f.toLocalDateTime() : null);
				chamados.add(chamado);
			}
			
			return chamados;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	public void deleteById(Long id) {
		
		try {
			
			String sql = "DELETE FROM model_chamado WHERE id = ?";
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
		}
		
	}

	public ModelChamado findById(Long id) {
		
		DAOLoginRepository userRepo = new DAOLoginRepository();
		DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
		
		try {
			
			ModelChamado chamado = new ModelChamado();
			
			String sql = "SELECT id, cliente, empresa_cliente, empresa_resp, descricao, criado_em, titulo, status, atendido_por, fechado_por, finalizado_em, resposta "
					+ "	FROM public.model_chamado WHERE id = ?;";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, id);
			ResultSet rs = statement.executeQuery();
			
			if(rs.next()) {
				chamado.setId(rs.getLong("id"));
				chamado.setCliente(userRepo.searchById(rs.getLong("cliente")));
				chamado.setEmpresaCliente(empresaRepo.findById(rs.getLong("empresa_cliente")));
				chamado.setEmpresaResp(empresaRepo.findById(rs.getLong("empresa_resp")));
				Timestamp c = rs.getTimestamp("criado_em");
				chamado.setCriadoEm(c !=null ? c.toLocalDateTime() : null);
				chamado.setTitulo(rs.getString("titulo"));
				chamado.setDescricao(rs.getString("descricao"));
				chamado.setStatus(rs.getString("status"));
				chamado.setAtentidoPor(userRepo.searchById(rs.getLong("atendido_por")));
				chamado.setFinalizadoPor(userRepo.searchById(rs.getLong("fechado_por")));
				Timestamp f = rs.getTimestamp("finalizado_em");
				chamado.setFinalizadoEm(f !=null ? f.toLocalDateTime() : null);
				chamado.setResposta(rs.getString("resposta"));
			}
			
			return chamado;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	public List<ModelChamado> findAllByEmpresaResp(Long empresaId, String status) {
		
		List<ModelChamado> chamados = new ArrayList<ModelChamado>();
		DAOLoginRepository userRepo = new DAOLoginRepository();
		DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
		
		try {
			
			String sql = "SELECT id, cliente, empresa_cliente, empresa_resp, criado_em, titulo, status, atendido_por, fechado_por, finalizado_em "
					+ "	FROM public.model_chamado WHERE empresa_resp = ? AND status = ?;";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, empresaId);
			statement.setString(2, status);
			ResultSet rs = statement.executeQuery();
			
			while(rs.next()) {
				ModelChamado chamado = new ModelChamado();
				chamado.setId(rs.getLong("id"));
				chamado.setCliente(userRepo.searchById(rs.getLong("cliente")));
				chamado.setEmpresaCliente(empresaRepo.findById(rs.getLong("empresa_cliente")));
				chamado.setEmpresaResp(empresaRepo.findById(rs.getLong("empresa_resp")));
				Timestamp c = rs.getTimestamp("criado_em");
				chamado.setCriadoEm(c !=null ? c.toLocalDateTime() : null);
				chamado.setTitulo(rs.getString("titulo"));
				chamado.setStatus(rs.getString("status"));
				chamado.setAtentidoPor(userRepo.searchById(rs.getLong("atendido_por")));
				chamado.setFinalizadoPor(userRepo.searchById(rs.getLong("fechado_por")));
				Timestamp f = rs.getTimestamp("finalizado_em");
				chamado.setFinalizadoEm(f !=null ? f.toLocalDateTime() : null);
				chamados.add(chamado);
			}
			
			return chamados;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public void alteraStatus(Long id, String status, Long userId) {
		
		DAOLoginRepository userRepo = new DAOLoginRepository();
		
		try {
			
			String sql = "";
			
			if(status!= null && !status.isEmpty() && status.equalsIgnoreCase("Em atendimento")) {
				sql = "UPDATE model_chamado SET status = ?, atendido_por = ? WHERE id = ?";
				PreparedStatement statement = connection.prepareStatement(sql);
				statement.setString(1, status);
				statement.setLong(2, userRepo.searchById(userId).getId());
				statement.setLong(3, id);
				statement.executeUpdate();
				connection.commit();
				
			}else if(status!= null && !status.isEmpty() && status.equalsIgnoreCase("Pendencia")) {
				sql = "UPDATE model_chamado SET status = ? WHERE id = ?";
				PreparedStatement statement = connection.prepareStatement(sql);
				statement.setString(1, status);
				statement.setLong(2, id);
				statement.executeUpdate();
				connection.commit();
			}

			
			
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}
		
	}
}
