package servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.DAOChamadoRepository;
import dao.DAOEmpresaRepository;
import dao.DAOLoginRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ModelChamado;

@WebServlet({ "/ServletChamadoController", "/principal/abrir-chamado/", "/principal/ver-chamados/" })
public class ServletChamadoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private DAOLoginRepository userRepo = new DAOLoginRepository();
	private DAOEmpresaRepository empresaRepo = new DAOEmpresaRepository();
	private DAOChamadoRepository chamadoRepo = new DAOChamadoRepository();
	
    public ServletChamadoController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//perfil de usuário
		String userPerfil = (String) request.getSession().getAttribute("perfilUser");
		
		//Abrir chamado page
		if(request.getRequestURI().contains("/principal/abrir-chamado/")) {
			request.getRequestDispatcher("/principal/abrir-chamado.jsp").forward(request, response);	
		}
		
		//Ver chamados page
		else if (request.getRequestURI().contains("/principal/ver-chamados/")) {
			
			List<ModelChamado> chamados = new ArrayList<ModelChamado>();
			
			if(userPerfil != null && !userPerfil.isEmpty() && userPerfil.equalsIgnoreCase("cliente")) {
				Long userId = (Long) request.getSession().getAttribute("userId");
				chamados = chamadoRepo.findAllByCliente(userId);				
				request.setAttribute("chamados", chamados);
			}
			
			request.getRequestDispatcher("/principal/ver-chamados.jsp").forward(request, response);	
		
		}else if(request.getRequestURI().contains("/ServletChamadoController")) {
			
			String acao = request.getParameter("acao");
			
			//Ações Servlet
			if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarAjax")) {
				
				Long id = Long.parseLong(request.getParameter("id") != null ? request.getParameter("id") : null);
				
				chamadoRepo.deleteById(id);
				
				response.getWriter().write("Chamado excluido com sucesso");
				
			}else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("verChamado")) {
				
				Long id = Long.parseLong(request.getParameter("id") != null ? request.getParameter("id") : null);

				ModelChamado chamado = chamadoRepo.findById(id);
				
				request.setAttribute("chamado", chamado);
				request.getRequestDispatcher("/principal/ver-chamado.jsp").forward(request, response);
			}
			
		} 
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//parâmetros do form
		String titulo = request.getParameter("titulo");
		String descricao = request.getParameter("descricao");
		
		//parametros da Session
		Long empresaCliente = (Long) request.getSession().getAttribute("empresaUserSession");
		String username = (String) request.getSession().getAttribute("usuario");
		
		ModelChamado chamado = new ModelChamado();
		chamado.setTitulo(titulo);
		chamado.setDescricao(descricao);
		chamado.setCliente(userRepo.searchByUser(username));
		chamado.setEmpresaCliente(empresaRepo.findById(empresaCliente));
		chamado.setEmpresaResp(empresaRepo.findEmpresaResp(empresaCliente));
		chamado.setCriadoEm(LocalDateTime.now());
		chamado.setStatus("aberto");
		
		try {
			
			chamadoRepo.save(chamado);
			
			request.setAttribute("msg", "Chamado registrado com êxito");
			request.getRequestDispatcher("/principal/abrir-chamado.jsp").forward(request, response);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
