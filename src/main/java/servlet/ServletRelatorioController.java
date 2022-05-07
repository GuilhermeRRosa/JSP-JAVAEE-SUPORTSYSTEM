package servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOChamadoRepository;
import dao.DAOLoginRepository;
import dao.DAOTelefoneRepository;
import dto.ModelLoginDTO;
import models.ModelTelefone;
import util.ReportUtil;

/**
 * Servlet implementation class ServletRelatorioController
 */
@WebServlet(urlPatterns = {"/ServletRelatorioController",
						   "/principal/ver-relatorios/",
						   "/principal/ver-relatorios/clientes/",
						   "/principal/ver-relatorios/chamados/"})
public class ServletRelatorioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServletRelatorioController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getRequestURI().contains("/principal/ver-relatorios/clientes/")) {
			
			String filtro = request.getParameter("filtro");
			byte[] relatorio = null;
			if(filtro != null && !filtro.isEmpty()) {						
				
				switch (filtro) {
				case "todos": {
					
					Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
					DAOLoginRepository usuRepo = new DAOLoginRepository();
					
					Date dataNascInicial = null;
					Date dataNascFinal = null;
					String dni = (String) request.getParameter("dataNascInicial");
					String dnf = (String) request.getParameter("dataNascFinal");
					
					if((dni != null && !dni.isEmpty()) && (dnf != null && !dnf.isEmpty())) {
						dataNascInicial = Date.valueOf(dni);
						dataNascFinal = Date.valueOf(dnf);
					}
					
					List<ModelLoginDTO> dados = new ArrayList<ModelLoginDTO>();
					String geraPDF = (String) request.getParameter("gerarPDF");		
					
					if(dataNascInicial != null && dataNascFinal !=null) {
						dados = usuRepo.findAllByEmpresaResp(0, empresaResp, dataNascInicial, dataNascFinal);
					}else {
						dados = usuRepo.findAllByEmpresaResp(0, empresaResp);	
					}
					
					if(geraPDF != null && !geraPDF.isEmpty() && geraPDF.equalsIgnoreCase("gerar")) {
						try {
							relatorio = new ReportUtil().geraRelatorioPDF(dados, "rel-usuarios", request.getServletContext());
							response.setHeader("Content-Disposition", "attatchment;filename=arquivo.pdf");
							response.getOutputStream().write(relatorio);
							return;
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					
					request.setAttribute("dados", dados);
					
				}
				break;
				
				case "esp": {
								
					  String usuario_username = request.getParameter("username-esp");
					  DAOLoginRepository usuRepo = new DAOLoginRepository();
					  DAOTelefoneRepository teleRepo = new DAOTelefoneRepository();
					  String geraPDF = (String) request.getParameter("gerarPDF");	
					  
					  ModelLoginDTO usuario = new ModelLoginDTO(usuRepo.getUserByUsername(usuario_username));  		
					  
					  if(geraPDF != null && !geraPDF.isEmpty() && geraPDF.equalsIgnoreCase("gerar")) {
							try {
								
								HashMap<String, Object> params = new HashMap<String, Object>();
								
								String realPath = request.getServletContext().getRealPath("/principal/files-upload/").replaceAll("\\\\", "\\/");
								realPath = realPath.substring(0, realPath.length() - 1);
								
								List<ModelTelefone> DadosTelefones = teleRepo.listByUserId(usuario.getId());
								
								List<String> telefones = new ArrayList<String>();
								for(int i = 0; i < DadosTelefones.size(); i++) {
									telefones.add(DadosTelefones.get(i).getNumero());
								}
								
								params.put("PARAM_OBJ", usuario);
								params.put("PARAM_REALPATH", realPath);
								params.put("PARAM_TELEFONES", telefones);
								params.put("PARAM_FILEPATH", request.getServletContext().getRealPath("relatorios") + File.separator);
								
								relatorio = new ReportUtil().geraRelatorioPDF(telefones, params, "rel-usu-esp", request.getServletContext());
								response.setHeader("Content-Disposition", "attatchment;filename=arquivo.pdf");
								response.getOutputStream().write(relatorio);
								return;
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					  
					  request.setAttribute("espUsu", usuario);
					
				}
				break;
				default:
					throw new IllegalArgumentException("Unexpected value: " + filtro);
				}	
			}
			request.getRequestDispatcher("/principal/ver-relatorios-clientes.jsp").forward(request, response);
			
		}else if(request.getRequestURI().contains("/principal/ver-relatorios/chamados/")) {
			
			request.getRequestDispatcher("/principal/ver-relatorios-chamados.jsp").forward(request, response);
			
		}else if(request.getRequestURI().contains("/ServletRelatorioController")) {
			
			String acao = request.getParameter("acao");
			
			//Ações GET
			if(acao != null && !acao.isEmpty() && acao.contains("gerarRelatorio")) {
				
				Long empresaId = (Long) request.getSession().getAttribute("empresaUserSession");
				DAOChamadoRepository chamadoRepo = new DAOChamadoRepository();
				String de = (String) request.getParameter("de");
				String para = (String) request.getParameter("para");
				Timestamp finalizadoEm = null;
				
				if(de == null || de.isEmpty()) {
					de = "2015-01-01";
				}
				
				if(para == null || para.isEmpty()) {
					finalizadoEm = new Timestamp(new java.util.Date().getTime());
				}else {
					finalizadoEm = new Timestamp(Date.valueOf(para).getTime());
				}
				
				Timestamp criadoEm = new Timestamp(Date.valueOf(de).getTime());
				
				ObjectMapper mapper = new ObjectMapper();
				
				String json = mapper.writeValueAsString(chamadoRepo.dadosRelatorioBarras(empresaId, criadoEm, finalizadoEm));
				
				response.getWriter().write(json);

			}
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
