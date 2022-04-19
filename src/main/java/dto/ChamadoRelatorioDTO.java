package dto;

import java.io.Serializable;

public class ChamadoRelatorioDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer chamados = 0;
	private Integer chamadosConcluidos = 0;
	private Integer chamadosEmAtendimento = 0;
	private Integer chamadosPendencia = 0;
	private Integer chamadosAbertos = 0;
	
	public Integer getChamados() {
		return chamados;
	}
	
	public void somaAberto() {chamadosAbertos++;}
	public void somaPendencia() {chamadosPendencia++;}
	public void somaConcluido() {chamadosConcluidos++;}
	public void somaEmAtendimento() {chamadosEmAtendimento++;}
	
	public void setChamados(Integer chamados) {
		this.chamados = chamados;
	}
	public Integer getChamadosConcluidos() {
		return chamadosConcluidos;
	}
	public void setChamadosConcluidos(Integer chamadosConcluidos) {
		this.chamadosConcluidos = chamadosConcluidos;
	}
	public Integer getChamadosEmAtendimento() {
		return chamadosEmAtendimento;
	}
	public void setChamadosEmAtendimento(Integer chamadosEmAtendimento) {
		this.chamadosEmAtendimento = chamadosEmAtendimento;
	}
	public Integer getChamadosPendencia() {
		return chamadosPendencia;
	}
	public void setChamadosPendencia(Integer chamadosPendencia) {
		this.chamadosPendencia = chamadosPendencia;
	}
	public Integer getChamadosAbertos() {
		return chamadosAbertos;
	}
	public void setChamadosAbertos(Integer chamadosAbertos) {
		this.chamadosAbertos = chamadosAbertos;
	}
	
	
}
