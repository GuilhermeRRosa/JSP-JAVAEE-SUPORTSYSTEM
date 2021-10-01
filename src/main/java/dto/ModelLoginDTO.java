package dto;

import java.io.Serializable;

import models.ModelLogin;

public class ModelLoginDTO implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	private String nome;
	private String email;
	private String username;
	private String genero;
	private String userImage;
	private boolean admin;

	public ModelLoginDTO(ModelLogin model) {
		this.setId(model.getId());
		this.setNome(model.getNome());
		this.setUser(model.getUser());
		this.setEmail(model.getEmail());
		this.setAdmin(model.isAdmin());
		this.setGenero(model.getGenero());
		this.setUserImage(model.getUserImage());
	}

	public ModelLoginDTO() {
	}
	
	public String getUserImage() {
		return userImage;
	}

	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}

	public String getGenero() {
		return genero;
	}

	public void setGenero(String genero) {
		this.genero = genero;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUser() {
		return username;
	}

	public void setUser(String user) {
		this.username = user;
	}
}
