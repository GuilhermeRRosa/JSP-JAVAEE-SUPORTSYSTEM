package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.DAOChamadoRepository;
import dao.DAOEmpresaRepository;
import dao.DAOLoginRepository;
import dto.ModelLoginDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ModelChamado;
import models.ModelEmpresa;

@WebServlet(urlPatterns = {"/ServletInicio", "/principal/inicio"})
public class ServletInicio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletInicio() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		preparaPagina(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/inicio.jsp");
		dispatcher.forward(request, response);	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		preparaPagina(req, resp);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/principal/inicio.jsp");
		dispatcher.forward(req, resp);
	}
	
	public static void preparaPagina(HttpServletRequest req, HttpServletResponse resp) {
		DAOLoginRepository loginRepo = new DAOLoginRepository();
		DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
		
		//VARIÁVEIS DE PÁGINAS DE INICIO PERSONALIZADAS
		String perfilUser = (String) req.getSession().getAttribute("perfilUser");
		if(perfilUser != null && !perfilUser.isEmpty()) {
			
			//PAGINA INICIAL ADMIN
			if(perfilUser.equalsIgnoreCase("admin")) {
				List<ModelLoginDTO> ultimosCadastrados = new ArrayList<ModelLoginDTO>();
				List<ModelEmpresa> ultimosCadastradosE = new ArrayList<ModelEmpresa>();
				ultimosCadastrados = loginRepo.findAll();
				ultimosCadastradosE = empresaRepo.findAllPagination(0);
				req.setAttribute("ultimosCadastrados", ultimosCadastrados);
				req.setAttribute("ultimosCadastradosE", ultimosCadastradosE);
				
			//PAGINA INICIAL ADMINISTRADOR DA EMPRESA
			}else if(perfilUser.equalsIgnoreCase("administrador")) {
				
			//PAGINA INICIAL CLIENTE
			}else if(perfilUser.contains("cliente")) {
				//TO DO
			}
		}
	}
}
