package servlet;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOLoginRepository;
import dao.DAOTelefoneRepository;
import dto.ModelLoginDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ModelTelefone;


@WebServlet( urlPatterns = {"/ServletTelefoneController", "/principal/ver-contatos"})
public class ServletTelefoneController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServletTelefoneController() {
        super();
    }

	/*
	 * @Override protected void service(HttpServletRequest req, HttpServletResponse
	 * resp) throws ServletException, IOException { DAOLoginRepository userRepo =
	 * new DAOLoginRepository();
	 * 
	 * String pagina = req.getParameter("pag");
	 * 
	 * Integer nPagina = pagina != null && !pagina.isEmpty() ?
	 * Integer.parseInt(pagina) : 1;
	 * 
	 * req.setAttribute("listaUser", userRepo.findAllPagination(nPagina)); }
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DAOLoginRepository userRepo = new DAOLoginRepository();
		DAOTelefoneRepository teleRepo = new DAOTelefoneRepository();
	
		if(request.getRequestURI().contains("/principal/ver-contatos")) {

			request.setAttribute("totalPaginas", userRepo.countPaginas());
			request.getRequestDispatcher("/principal/ver-contatos.jsp").forward(request, response);			
		}
		
		if(request.getRequestURI().contains("/ServletTelefoneController")) {		
				
			String acao = request.getParameter("acao");
			
			if(acao != null && !acao.isEmpty() && acao.equals("buscarComAjax")) {
				
				String pagina = request.getParameter("pag");
				Integer nPagina = pagina != null && !pagina.isEmpty() ? Integer.parseInt(pagina) : 1;
				
				List<ModelLoginDTO> listaUsers = userRepo.findAllPagination(nPagina);
				
				ObjectMapper mapper = new ObjectMapper();
				try {
					String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(listaUsers);
					response.getWriter().write(json);
				}catch (Exception e) {
					e.printStackTrace();
				}		
			}else if(acao != null && !acao.isEmpty() && acao.equals("listarTelefones")) {
				
				String id = request.getParameter("id");
				Long nId = id !=null && !id.isEmpty() ? Long.parseLong(id) : null;
				
				List<ModelTelefone> telefones = teleRepo.listByUserId(nId);
				
				ObjectMapper mapper = new ObjectMapper();
				
				try {
					String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(telefones);
					response.getWriter().write(json);
				} catch (Exception e) {
					e.printStackTrace();
				}	
			}else if(acao != null && !acao.isEmpty() && acao.equals("removerTelefone")) {
				String id = request.getParameter("id");
				Long nId = id !=null && !id.isEmpty() ? Long.parseLong(id) : null;
				
				teleRepo.deleteById(nId);
				
				response.getWriter().write("Telefone removido com sucesso!");
			}
		}				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DAOLoginRepository userRepo = new DAOLoginRepository();
		DAOTelefoneRepository teleRepo = new DAOTelefoneRepository();
		
		String acao = request.getParameter("acao");
		
		if(acao != null && !acao.isEmpty() && acao.equals("cadastraTelefone")) {
			
			String id = request.getParameter("id");
			Long nId = id !=null && !id.isEmpty() ? Long.parseLong(id) : null;	
			String numero = request.getParameter("numero");
			
			teleRepo.save(numero, nId);	
			
		}
		
		doGet(request, response);
	}

}
