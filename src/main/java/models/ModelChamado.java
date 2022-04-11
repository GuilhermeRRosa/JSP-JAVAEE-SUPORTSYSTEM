package models;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Objects;

public class ModelChamado implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long id;
	private ModelLogin cliente;
	private ModelEmpresa empresaCliente;
	private ModelEmpresa empresaResp;
	private Timestamp criadoEm;
	private Timestamp finalizadoEm;
	private String titulo;
	private String descricao;
	private String resposta;
	private String status;
	private ModelLogin atentidoPor;
	private ModelLogin finalizadoPor;

	public ModelChamado() {

	}

	public String getResposta() {
		return resposta;
	}

	public void setResposta(String resposta) {
		this.resposta = resposta;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ModelLogin getCliente() {
		return cliente;
	}

	public void setCliente(ModelLogin cliente) {
		this.cliente = cliente;
	}

	public ModelEmpresa getEmpresaCliente() {
		return empresaCliente;
	}

	public void setEmpresaCliente(ModelEmpresa empresaCliente) {
		this.empresaCliente = empresaCliente;
	}

	public ModelEmpresa getEmpresaResp() {
		return empresaResp;
	}

	public void setEmpresaResp(ModelEmpresa empresaResp) {
		this.empresaResp = empresaResp;
	}

	public Timestamp getCriadoEm() {
		return criadoEm;
	}

	public void setCriadoEm(Timestamp criadoEm) {
		this.criadoEm = criadoEm;
	}

	public Timestamp getFinalizadoEm() {
		return finalizadoEm;
	}

	public void setFinalizadoEm(Timestamp finalizadoEm) {
		this.finalizadoEm = finalizadoEm;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public ModelLogin getAtentidoPor() {
		return atentidoPor;
	}

	public void setAtentidoPor(ModelLogin atentidoPor) {
		this.atentidoPor = atentidoPor;
	}

	public ModelLogin getFinalizadoPor() {
		return finalizadoPor;
	}

	public void setFinalizadoPor(ModelLogin finalizadoPor) {
		this.finalizadoPor = finalizadoPor;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ModelChamado other = (ModelChamado) obj;
		return Objects.equals(id, other.id);
	}

}
