package filters;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import connection.SingleConnection;
import dao.DaoVersionadorBanco;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


//URL que o filter irá capturar. No caso todos os arquivos dentro de
//principal irão passar pelo filtro
@WebFilter(urlPatterns = {"/principal/*"})
public class AuthenticationFilter implements Filter {

	private static Connection connection;

    public AuthenticationFilter() {
    }

    //Código a ser executado ao desligar o servidor
    //Ex.: fechar conexão com o banco
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
		//converte o request para um HttpServletRequest
		HttpServletRequest req = (HttpServletRequest) request;
		//Obtém o objeto session atual
		HttpSession session = req.getSession();
		//Obtém-se o usuário logado na session, este usuário é setado no ServletLogin
		String actualUser = (String) session.getAttribute("usuario");
		//Captura o URL que está tentando ser acessado no momento
		//Esta url estará vindo como parâmetro da página de Login, veja no ServletLogin
		String urlAuth = req.getServletPath();

		//Se o actualUser não estiver logado, redireciona para a página de Login
		if(actualUser==null && !urlAuth.equalsIgnoreCase("/principal/ServletLogin")) {

			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp?url="+urlAuth);
			request.setAttribute("msg", "Por favor, realize o login.");
			dispatcher.forward(request, response);
			return; // PARA A EXECUÇÃO E REDIRECIONA PARA O LOGIN
		}else {
			chain.doFilter(request, response);
		}

		connection.commit();

		}catch (Exception e) {
			try {
				connection.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}
	}

	//codigo a ser executado ao ser iniciado o servidor
	//Ex.: Iniciar o banco de dados
	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnection.getConnection();
		
		DaoVersionadorBanco vers = new DaoVersionadorBanco();
		
		String caminhoPastaSQL = fConfig.getServletContext().getRealPath("/versionadorbancosql") + File.separator;
		
		File[] files =  new File(caminhoPastaSQL).listFiles();
		
		for(File file : files) {
			try {
				boolean arquivoJaRodado = vers.arquivoSqlRodado(file.getName());
				
				if(!arquivoJaRodado) {
					FileInputStream entradaArquivo = new FileInputStream(file);
					
					Scanner lerArquivo = new Scanner(entradaArquivo, "UTF-8");
					
					StringBuilder sql = new StringBuilder();
					
					while(lerArquivo.hasNext()) {
						sql.append(lerArquivo.nextLine());
						sql.append("\n");
					}
					
					connection.prepareStatement(sql.toString()).execute();
					vers.gravaArquivoSqlRodado(file.getName());
					connection.commit();
					lerArquivo.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
