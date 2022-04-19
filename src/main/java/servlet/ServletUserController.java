package servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOEmpresaRepository;
import dao.DAOLoginRepository;
import dto.ModelLoginDTO;
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
@WebServlet(urlPatterns = {"/ServletUserController", "/principal/ver-usuarios"})
public class ServletUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DAOLoginRepository userRepo = new DAOLoginRepository();
         
    public ServletUserController() {}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String acao = request.getParameter("acao");
			
			//Se a URL de requisição for igual a /ver-susuarios, retorna a lista de usuarios e direciona a pagina
			if(request.getRequestURI().contains("/principal/ver-usuarios")) {
				
				String userPerfil = (String) request.getSession().getAttribute("perfilUser");
				
				if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("admin")) {
					request.setAttribute("totalPaginas", userRepo.countPaginas());
					request.setAttribute("totalUsers", userRepo.countUsers());
				}else if (userPerfil != null && !userPerfil.isEmpty() && (userPerfil.equalsIgnoreCase("administrador") || userPerfil.equalsIgnoreCase("colaborador"))) {
					Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
					request.setAttribute("totalPaginas", userRepo.countPaginas(empresaResp));
					int u = userRepo.countUsers(empresaResp);
					request.setAttribute("totalUsers", userRepo.countUsers(empresaResp));
				}
				
				
				request.getRequestDispatcher("/principal/ver-usuarios.jsp").forward(request, response);
				
			}
			
			//Ações GET - procedural
			if(acao != null && !acao.isEmpty() && acao.equals("buscarComAjax")) {
				
				String nomeP = request.getParameter("nomeP");
				List<ModelLoginDTO> userSearch = new ArrayList<ModelLoginDTO>();
				
				if(nomeP != null && !nomeP.isEmpty()) {
					String userPerfil = (String) request.getSession().getAttribute("perfilUser");
					
					if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("admin")) {
						userSearch = userRepo.findByName(nomeP);
					}else if (userPerfil != null && !userPerfil.isEmpty() && (userPerfil.equalsIgnoreCase("administrador") || userPerfil.equalsIgnoreCase("colaborador"))) {
						Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
						userSearch = userRepo.findByName(nomeP, empresaResp);
					}	
					
					//transformando a lista em JSON com Jackson
					ObjectMapper mapper = new ObjectMapper();
					try {
				         String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(userSearch);
				         response.getWriter().write(json);
				      } catch(Exception e) {
				         e.printStackTrace();
				      }			
				}	
			}else if(acao != null && !acao.isEmpty() && acao.equals("deletarComAjax")) {
				
				String sid = request.getParameter("id");
				Long id = sid != null && !sid.isEmpty() ? Long.parseLong(sid) : null;
				
				if(id != null) {
					userRepo.deleteById(id);
					response.getWriter().write("Usuário removido com sucesso!");
				}	
			}else if(acao != null && !acao.isEmpty() && acao.equals("editarUser")) {
				
				String sid = request.getParameter("id");
				String rzSocial = request.getParameter("rzSocial");
				Long id_empresa = Long.parseLong(request.getParameter("id_empresa"));
				Long id = sid != null && !sid.isEmpty() ? Long.parseLong(sid) : null;
				
				if(id != null) {
					ModelLoginDTO user = new ModelLoginDTO(userRepo.searchById(id));
					request.setAttribute("userDto", user);
					request.setAttribute("razaoSocial", rzSocial);
					request.setAttribute("empresa_id", id_empresa);
					request.setAttribute("msg", "Editando usuário "+user.getNome());					
					request.getRequestDispatcher("/principal/cadastrar-usuario.jsp").forward(request, response);
				}
				
			}else if(acao != null && !acao.isEmpty() && acao.equals("listarComAjax")){
				String pagina = request.getParameter("pag");			
				Integer nPagina = pagina != null && !pagina.isEmpty() ? Integer.parseInt(pagina) : 1;
				String userPerfil = (String) request.getSession().getAttribute("perfilUser");
				List<ModelLoginDTO> allUsers = new ArrayList<ModelLoginDTO>();
				
				if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("admin")) {
					allUsers = userRepo.findAllPagination(nPagina);
				}else if (userPerfil != null && !userPerfil.isEmpty() && (userPerfil.equalsIgnoreCase("administrador") || userPerfil.equalsIgnoreCase("colaborador"))) {
					Long empresaResp = (Long) request.getSession().getAttribute("empresaUserSession");
					allUsers = userRepo.findAllByEmpresaResp(nPagina, empresaResp);	
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
			
			DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
			
			//dados vindos do front
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String username = request.getParameter("user");
			String password = request.getParameter("password");
			String perfil = request.getParameter("perfil");
			String genero = request.getParameter("genero");
			String cep = request.getParameter("cep");
			String logradouro = request.getParameter("logradouro");
			String bairro = request.getParameter("bairro");
			String cidade = request.getParameter("cidade");
			String uf = request.getParameter("uf");
			String empresa = request.getParameter("empresa");
			String acao = request.getParameter("acao");
			Date dataNasc = Date.valueOf(request.getParameter("dataNasc"));
			
			ModelLogin model = new ModelLogin();
			if(empresa == null || empresa.isEmpty())
				empresa = "0";
			ModelEmpresa userEmpresa = empresaRepo.findById(empresa != null && !empresa.isEmpty() ? Long.parseLong(empresa) : null);
			//Settando tipo de dados corretos para o modelo
			
			final Part part = request.getPart("userImage");
			model.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			model.setNome(nome);
			model.setEmail(email);
			model.setUser(username);
			model.setPassword(password);
			model.setPerfil(perfil);
			model.setGenero(genero);
			model.setCep(cep);
			model.setLogradouro(logradouro);
			model.setBairro(bairro);
			model.setCidade(cidade);
			model.setUf(uf);			
			model.setEmpresa(userEmpresa);	
			model.setDataNasc(dataNasc);
			 		
			//Ações POST
			if(model.getId()==null) {		
				try {  
	
					String realPath = request.getServletContext().getRealPath("/principal/files-upload/");
					
					//Se a imagem foi enviada
				    if(part != null && part.getSize() > 0) {
				    	
				    	//Setting do caminho para salvar 	
				    	File path = new File(realPath+model.getUser());
				    	//Se a pasta nao existir, cria uma nova
				    	if(!path.exists()) {
				    		path.mkdirs();
				    	}
				    	//Salta a imagem no server e seta o caminho do banco;
				    	String fileName = path+"\\"+"user_image."+part.getContentType().split("\\/")[1];
				    	part.write(fileName);
					    model.setUserImage(request.getContextPath()+"/principal/files-upload/"+model.getUser()+"/user_image."+part.getContentType().split("\\/")[1]);
				    }else {
				    	//Caso não for carregada a imagem, uma imagem default é salva no perfil
				    	model.setUserImage(request.getContextPath()+"/principal/files-upload/default/profile.png");
				    }
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (!userRepo.verifyUsername(model.getUser())) {
					model = userRepo.save(model);
					request.setAttribute("msg", "Usuário cadastrado com sucesso");					
				}else {
					request.setAttribute("msg", "Nome de usuário já existe");		
					ModelLoginDTO userDto = new ModelLoginDTO(model);
					
					request.setAttribute("userDto", userDto);
					
					request.getRequestDispatcher("/principal/cadastrar-usuario.jsp").forward(request, response);	
					return;
				}
			}else{
				
				if(part != null && part.getSize() > 0) {
					String realPath = request.getServletContext().getRealPath("/principal/files-upload/");
					//Setting do caminho para salvar 	
			    	File path = new File(realPath+model.getUser());
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
				    model.setUserImage(request.getContextPath()+"/principal/files-upload/"+model.getUser()+"/user_image."+part.getContentType().split("\\/")[1]);
				}else {
					model.setUserImage(userRepo.searchById(model.getId()).getUserImage());
				}
				model = userRepo.update(model);
				request.setAttribute("msg", "Usuário atualizado com sucesso");
			}
			
			//Ação Pós Operação
			ModelLoginDTO userDto = new ModelLoginDTO(model);
			
			request.setAttribute("userDto", userDto);
			
			request.getRequestDispatcher("/principal/cadastrar-usuario.jsp").forward(request, response);							
			
		} catch (Exception e) {
			e.printStackTrace();			
			request.setAttribute("msg", e.getMessage());
			request.getRequestDispatcher("erro.jsp").forward(request, response);
			return;
		}
		
	}

}
