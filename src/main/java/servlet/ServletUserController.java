package servlet;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOLoginRepository;
import dto.ModelLoginDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import models.ModelLogin;

/**
 * Classe controladora do cadstro de usuário
 */

@MultipartConfig // anotação para receber dados FILE do form
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
				
				List<ModelLoginDTO> allUsers = userRepo.findAll();
				
				request.setAttribute("allUsers", allUsers);
				request.getRequestDispatcher("/principal/ver-usuarios.jsp").forward(request, response);
				
			}
			
			//Ações GET - procedural1
			if(acao != null && !acao.isEmpty() && acao.equals("buscarComAjax")) {
				
				String nomeP = request.getParameter("nomeP");
				
				if(nomeP != null && !nomeP.isEmpty()) {
					List<ModelLoginDTO> userSearch = userRepo.findByName(nomeP);
					
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
				Long id = sid != null && !sid.isEmpty() ? Long.parseLong(sid) : null;
				
				if(id != null) {
					ModelLoginDTO user = new ModelLoginDTO(userRepo.searchById(id));
					request.setAttribute("userDto", user);
					request.setAttribute("msg", "Editando usuário "+user.getNome());					
					request.getRequestDispatcher("/principal/cadastrar-usuario.jsp").forward(request, response);
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
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String username = request.getParameter("user");
			String password = request.getParameter("password");
			String admin = request.getParameter("admin");
			String genero = request.getParameter("genero");
			
			ModelLogin model = new ModelLogin();
			//Settando tipo de dados corretos para o modelo
			model.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			model.setNome(nome);
			model.setEmail(email);
			model.setUser(username);
			model.setPassword(password);
			model.setAdmin(admin != null && !admin.isEmpty() ? Boolean.parseBoolean(admin) : null);
			model.setGenero(genero);
			final Part part = request.getPart("userImage");
			 		
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
				    	model.setUserImage(realPath+"default\\profile.png");
				    }
				} catch (Exception e) {
					e.printStackTrace();
				}
				model = userRepo.save(model);
				request.setAttribute("msg", "Usuário cadastrado com sucesso");
			}else{
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
				    	//Salva a imagem no server e seta o caminho do banco;
				    	String fileName = path+"/"+"user_image."+part.getContentType().split("\\/")[1];
				    	part.write(fileName);
				    	
				    	//Salva o caminho da imagem com contexto do projeto no servidor
					    model.setUserImage(request.getContextPath()+"/principal/files-upload/"+model.getUser()+part.getContentType().split("\\/")[1]);
				    }
				} catch (Exception e) {
					e.printStackTrace();
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
		}
		
	}

}
