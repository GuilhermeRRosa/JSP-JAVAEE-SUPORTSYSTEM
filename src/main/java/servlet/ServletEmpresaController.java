package servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOEmpresaRepository;
import dao.DAOLoginRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import models.ModelEmpresa;
import models.ModelLogin;

/**
 * Classe controladora do cadstro de usuário
 */

@MultipartConfig(maxFileSize=1024*1024*5) // anotação para receber dados FILE do form
@WebServlet(urlPatterns = {"/ServletEmpresaController", "/principal/ver-empresas"})
public class ServletEmpresaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DAOLoginRepository userRepo = new DAOLoginRepository();
	private DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
         
    public ServletEmpresaController() {}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String acao = request.getParameter("acao");
			
			//Se a URL de requisição for igual a /ver-susuarios, retorna a lista de usuarios e direciona a pagina
			if(request.getRequestURI().contains("/principal/ver-empresas")) {
				
				String userPerfil = (String) request.getSession().getAttribute("perfilUser");
				
				if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("admin")) {
					request.setAttribute("totalPaginas", empresaRepo.countPaginas());
					request.setAttribute("totalUsers", empresaRepo.countUsers());
				}else if (userPerfil != null && !userPerfil.isEmpty() && (userPerfil.equalsIgnoreCase("administrador") || userPerfil.equalsIgnoreCase("colaborador"))) {
					Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
					request.setAttribute("totalPaginas", empresaRepo.countPaginasByPerfil(empresaResp));
					request.setAttribute("totalUsers", empresaRepo.countUsersByPerfil(empresaResp));
				}
				
				
				request.getRequestDispatcher("/principal/ver-empresas.jsp").forward(request, response);
				
			}
			
			//Ações GET - procedural
			if(acao != null && !acao.isEmpty() && acao.equals("buscarComAjax")) {
				
				String razaoSocial = request.getParameter("razaoSocial");
				List<ModelEmpresa> empresaSearch = new ArrayList<ModelEmpresa>();
				
				if(razaoSocial != null && !razaoSocial.isEmpty()) {
					
					String userPerfil = (String) request.getSession().getAttribute("perfilUser");
					
					if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("admin")) {
						empresaSearch = empresaRepo.findByRazaoSocial(razaoSocial);
					}else if (userPerfil != null && !userPerfil.isEmpty() && (userPerfil.equalsIgnoreCase("administrador") || userPerfil.equalsIgnoreCase("colaborador"))) {
						Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
						empresaSearch = empresaRepo.findByRazaoSocial(razaoSocial, empresaResp);
					}
					
					//transformando a lista em JSON com Jackson
					ObjectMapper mapper = new ObjectMapper();
					try {
				         String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(empresaSearch);
				         response.getWriter().write(json);
				      } catch(Exception e) {
				         e.printStackTrace();
				      }			
				}	
			}else if(acao != null && !acao.isEmpty() && acao.equals("deletarComAjax")) {
				
				String sid = request.getParameter("id");
				Long id = sid != null && !sid.isEmpty() ? Long.parseLong(sid) : null;
				
				if(id != null) {
					empresaRepo.deleteById(id);
					response.getWriter().write("Empresa removida com sucesso!");
				}	
			}else if(acao != null && !acao.isEmpty() && acao.equals("editarEmpresa")) {
				
				String sid = request.getParameter("id");
				Long id = sid != null && !sid.isEmpty() ? Long.parseLong(sid) : null;
				
				if(id != null) {
					ModelEmpresa empresa = empresaRepo.findById(id);
					request.setAttribute("empresa", empresa);
					request.setAttribute("msg", "Editando empresa "+empresa.getRazaoSocial());					
					request.setAttribute("representante", empresa.getRepresentante().getNome());					
					request.getRequestDispatcher("/principal/cadastrar-empresa.jsp").forward(request, response);
				}	
			}else if(acao != null && !acao.isEmpty() && acao.equals("listarComAjax")){
				String pagina = request.getParameter("pag");	
				Integer nPagina = pagina != null && !pagina.isEmpty() ? Integer.parseInt(pagina) : 1;
				List<ModelEmpresa> allUsers = new ArrayList<ModelEmpresa>();
				String userPerfil = (String) request.getSession().getAttribute("perfilUser");
				
				if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("admin")) {
					allUsers = empresaRepo.findAllPagination(nPagina);	
				}else if (userPerfil != null && !userPerfil.isEmpty() && (userPerfil.equalsIgnoreCase("administrador") || userPerfil.equalsIgnoreCase("colaborador"))) {
					Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
					allUsers = empresaRepo.findAllPaginationByPerfil(nPagina, empresaResp);
				}
				
				ObjectMapper mapper = new ObjectMapper();
				try {
					String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(allUsers);
					response.getWriter().write(json);
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", e.getMessage());
			request.getRequestDispatcher("erro.jsp").forward(request, response);
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			//dados vindos do front
			String id = request.getParameter("id");
			String cnpj = request.getParameter("cnpj");
			String razaoSocial = request.getParameter("razaoSocial");
			String email = request.getParameter("email");
			String ramo = request.getParameter("ramo");
			String telefone = request.getParameter("telefone");
			String perfil = request.getParameter("perfil");
			String cep = request.getParameter("cep");
			String logradouro = request.getParameter("logradouro");
			String bairro = request.getParameter("bairro");
			String cidade = request.getParameter("cidade");
			String uf = request.getParameter("uf");
			String representante = request.getParameter("representante");
			String acao = request.getParameter("acao");
			
			ModelEmpresa model = new ModelEmpresa();
			ModelLogin userRepresentante = userRepo.searchById(representante != null && !representante.isEmpty() ? Long.parseLong(representante) : null);
			//Settando tipo de dados corretos para o modelo
			
			final Part part = request.getPart("userImage");
			model.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			model.setCnpj(cnpj);
			model.setRazaoSocial(razaoSocial);
			model.setEmail(email);
			model.setRamo(ramo);
			model.setTelefone(telefone);
			model.setPerfil(perfil);
			model.setCep(cep);
			model.setLogradouro(logradouro);
			model.setBairro(bairro);
			model.setCidade(cidade);
			model.setUf(uf);		
			model.setRepresentante(userRepresentante);
			 		
			//Ações POST
			if(model.getId()==null) {
				
				try {  
					String realPath = request.getServletContext().getRealPath("/principal/files-upload/empresas/");
					
					//Se a imagem foi enviada
				    if(part != null && part.getSize() > 0) {
				    	
				    	//Setting do caminho para salvar 	
				    	File path = new File(realPath+model.getRazaoSocial());
				    	
				    	//Se a pasta nao existir, cria uma nova
				    	if(!path.exists()) {
				    		path.mkdirs();
				    	}
				    	
				    	//Salta a imagem no server e seta o caminho do banco;
				    	String fileName = path+"\\"+"user_image."+part.getContentType().split("\\/")[1];
				    	part.write(fileName);
					    model.setLogo(request.getContextPath()+"/principal/files-upload/empresas/"+model.getRazaoSocial()+"/user_image."+part.getContentType().split("\\/")[1]);
				    }else {
				    	//Caso não for carregada a imagem, uma imagem default é salva no perfil
				    	model.setLogo(request.getContextPath()+"/principal/files-upload/default/profile.png");
				    }
				} catch (Exception e) {
					e.printStackTrace();
				}
				Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
				model = empresaRepo.save(model, empresaResp);
				request.setAttribute("msg", "Empresa cadastrada com sucesso");
			}else{
				
				if(part != null && part.getSize() > 0) {
					String realPath = request.getServletContext().getRealPath("/principal/files-upload/empresas/");
					//Setting do caminho para salvar 	
			    	File path = new File(realPath+model.getRazaoSocial());
			    	//Se a pasta nao existir, cria uma nova
			    	if(!path.exists()) {
			    		path.mkdirs();
			    	}
			    	
			    	//Deleta o conteúdo da pasta
			    	if (path.isDirectory()) {
			    		File[] sun = path.listFiles();
			    		for (File toDelete : sun) {
			    			toDelete.delete();
			    		}
			    	}
			    	
			    	//Salta a imagem no server e seta o caminho do banco;
			    	String fileName = path+"\\"+"user_image."+part.getContentType().split("\\/")[1];
			    	part.write(fileName);
				    model.setLogo(request.getContextPath()+"/principal/files-upload/empresas/"+model.getRazaoSocial()+"/user_image."+part.getContentType().split("\\/")[1]);
				}else {
					model.setLogo(request.getContextPath()+"/principal/files-upload/default/profile.png");
				}
				Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
				model = empresaRepo.update(model, empresaResp);
				request.setAttribute("msg", "Empresa atualizada com sucesso");
			}
			
			//Ação Pós Operação			
			request.setAttribute("empresa", model);
			request.setAttribute("representante", model.getRepresentante().getNome());
			
			request.getRequestDispatcher("/principal/cadastrar-empresa.jsp").forward(request, response);							

			
		} catch (Exception e) {
			e.printStackTrace();			
			request.setAttribute("msg", e.getMessage());
			request.getRequestDispatcher("erro.jsp").forward(request, response);
			return;
		}
		
	}

}
