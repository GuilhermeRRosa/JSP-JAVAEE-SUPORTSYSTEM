package servlet;

import java.io.IOException;

import dao.DAOLoginRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ModelLogin;

@jakarta.servlet.annotation.WebServlet(urlPatterns = {"/principal/ServletLogin", "/ServletLogin"})
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public ServletLogin() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String acao = request.getParameter("acao");

		if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("logout")) {
			//Invalida a sessão, realizando o logout, todos os atributos da sessão tmb são removidos
			request.getSession().invalidate();
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else {
			doPost(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String user = request.getParameter("user");
			String password = request.getParameter("password");
			String url = request.getParameter("url");

			String msg = "";
			int errors = 0;

			//VALIDAÇÃO DOS CAMPOS
			if(user.isEmpty() || user==null) {
				msg+= " Usuário deve ser informado ";
				errors++;
			}

			if(password==null || password.isEmpty()) {
				msg+= " Senha deve ser informada ";
				errors++;
			}

			//Se não houver erros, tenta fazer o login
			if(errors > 0) {
				RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath()+"/index.jsp");
				request.setAttribute("msg", msg);
				dispatcher.forward(request, response);
			}else {
				ModelLogin modelLogin = new ModelLogin(user, password);
				DAOLoginRepository loginRepo = new DAOLoginRepository();

				if(url == null || url.equals("null")) {
					url = "principal/inicio.jsp";
				}

				//Verifica se o user e senha estão corretos
				if(loginRepo.authLogin(modelLogin)) {

					modelLogin = loginRepo.getUserByUsername(user);
					
					//GUARDA O USUARIO NA SESSÃO
					request.getSession().setAttribute("usuario", modelLogin.getUser());
					request.getSession().setAttribute("perfilUser", modelLogin.getPerfil());
					request.getSession().setAttribute("userImg", modelLogin.getUserImage());

					RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/inicio.jsp");
					dispatcher.forward(request, response);
				}else {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
					request.setAttribute("msg", " Usuário ou senha incorretos! ");
					dispatcher.forward(request, response);
				}
			}

		}catch (Exception e) {
			e.printStackTrace();

			//PAGINA DE ERROS INEXPERADOS
			RequestDispatcher dispatcher = request.getRequestDispatcher("/erro.jsp");
			dispatcher.forward(request, response);
		}


	}

}
