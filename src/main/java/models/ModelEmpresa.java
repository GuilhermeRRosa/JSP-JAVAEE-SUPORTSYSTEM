package models;

import java.io.Serializable;
import java.util.Objects;

public class ModelEmpresa implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long id;
	private String cnpj;
	private String razaoSocial;
	private String cep;
	private String logradouro;
	private String bairro;
	private String cidade;
	private String uf;
	private String telefone;
	private String ramo;
	private String email;
	private ModelLogin representante;
	private String perfil;
	private String logo;

	public ModelEmpresa() {
	}

	public String getPerfil() {
		return perfil;
	}

	public void setPerfil(String perfil) {
		this.perfil = perfil;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getRazaoSocial() {
		return razaoSocial;
	}

	public void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getLogradouro() {
		return logradouro;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getUf() {
		return uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getRamo() {
		return ramo;
	}

	public void setRamo(String ramo) {
		this.ramo = ramo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public ModelLogin getRepresentante() {
		return representante;
	}

	public void setRepresentante(ModelLogin representante) {
		this.representante = representante;
	}

	@Override
	public int hashCode() {
		return Objects.hash(cnpj, id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ModelEmpresa other = (ModelEmpresa) obj;
		return Objects.equals(cnpj, other.cnpj) && Objects.equals(id, other.id);
	}
}
