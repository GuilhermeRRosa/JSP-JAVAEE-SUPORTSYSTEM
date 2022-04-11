<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Projeto JSP</title>       
    <jsp:include page="fragments/head.jsp"></jsp:include>
</head>

  <body>
  <!-- Loading da página -->
  <jsp:include page="fragments/pre-loader.jsp"></jsp:include>
  
  <!-- Containers Wrappers -->
  <div id="pcoded" class="pcoded">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
          
          <!-- Main Header -->
          <jsp:include page="fragments/header.jsp"></jsp:include>

          <div class="pcoded-main-container">
              <div class="pcoded-wrapper">
                  
                  <!-- Menu SideBar -->
                  <jsp:include page="fragments/sidebar-menu.jsp"></jsp:include>
                  
                  <!-- Wrapper Content -->
                  <div class="pcoded-content">
                  
                      <!-- Page-header -->
                      <jsp:include page="fragments/page-header.jsp"></jsp:include>
                      
                        <div class="pcoded-inner-content">
                            <!-- Main-body start -->
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <!-- Page-body start -->
                                    <div class="page-body">
                                    <c:if test="${perfilUser=='cliente'}">
                                    	<h2 class="mb-3">Seus chamados</h2>
                                    </c:if>
                                        <div class="row">                     
                                        	<!-- Conteúdo aqui -->                                        	
                                        	<c:if test="${perfilUser=='admin'}">
                                        		<!-- Cards de usuários -->
                                        		<div class="col-md-6">
	                                                <div class="card">
	                                                    <div class="card-header">
	                                                        <h5>Ultimos usuários cadastrados</h5>
	                                                        <div class="card-header-right">
	                                                            <ul class="list-unstyled card-option">
	                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
	                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
	                                                                <li><i class="fa fa-minus minimize-card"></i></li>
	                                                                <li><i class="fa fa-refresh reload-card"></i></li>
	                                                                <li><i class="fa fa-trash close-card"></i></li>
	                                                            </ul>
	                                                        </div>
	                                                    </div>
	                                                    <div class="card-block">
	                                                        <c:forEach var="uc" items="${ultimosCadastrados}">
	                                                        	<div class="align-middle m-b-30">
		                                                            <img src="${uc.userImage}" alt="user image" class="img-radius img-40 align-top m-r-15">
		                                                            <div class="d-inline-block">
		                                                                <h6>${uc.nome}</h6>
		                                                                <p class="text-muted m-b-0">${uc.empresa.razaoSocial}</p>
		                                                            </div>
	                                                        	</div>
	                                                        </c:forEach>
	                                                        <div class="text-center">
	                                                            <a href="<%= request.getContextPath() %>/principal/ver-usuarios" class="b-b-primary text-primary">Ver Todos</a>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                            <div class="col-md-6">
	                                                <div class="card">
	                                                    <div class="card-header">
	                                                        <h5>Ultimas Empresas Cadastradas</h5>
	                                                        <div class="card-header-right">
	                                                            <ul class="list-unstyled card-option">
	                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
	                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
	                                                                <li><i class="fa fa-minus minimize-card"></i></li>
	                                                                <li><i class="fa fa-refresh reload-card"></i></li>
	                                                                <li><i class="fa fa-trash close-card"></i></li>
	                                                            </ul>
	                                                        </div>
	                                                    </div>
	                                                    <div class="card-block">
	                                                        <c:forEach var="uce" items="${ultimosCadastradosE}">
	                                                        	<div class="align-middle m-b-30">
		                                                            <img src="${uce.logo}" alt="user image" class="img-radius img-40 align-top m-r-15">
		                                                            <div class="d-inline-block">
		                                                                <h6>${uce.razaoSocial}</h6>
		                                                                <p class="text-muted m-b-0">${uce.representante.nome}</p>
		                                                            </div>
	                                                        	</div>
	                                                        </c:forEach>
	                                                        <div class="text-center">
	                                                            <a href="<%= request.getContextPath() %>/principal/ver-empresas" class="b-b-primary text-primary">Ver Todas</a>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
                                        	</c:if>                                        	
                                        	<c:if test="${perfilUser=='cliente'}">
                                        		<div class="col-md-6">
                                        			<div class="card funcoes">
                                        				<div class="card-header">
                                        					<h5 class="card-title">Ações</h5>
                                        				</div>
                                        				<div class="card-body h4">
															<div class="row mb-md-3">
																<div class="col-md-6 mb-3 mb-md-0">																	
																	<a class="btn-action bg-secondary text-light" href="<%= request.getContextPath() %>/principal/abrir-chamado/">
																		<i class="ti-check-box mr-2"></i> Abrir novo chamado
																	</a>
																</div>
																<div class="col-md-6 mb-3 mb-md-0">
																	<a class="btn-action bg-secondary text-light" href="<%= request.getContextPath() %>/principal/ver-chamados/">
																		<i class="ti-pencil mr-2"></i>Ver meus chamados
																	</a>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6 mb-3 mb-md-0">
																	<a class="btn-action bg-secondary text-light" href="<%= request.getContextPath() %>/principal/ver-concluidos">
																		<i class="ti-folder mr-2"></i>Ver concluídos
																	</a>
																</div>
																<div class="col-md-6">
																	<a class="btn-action bg-secondary text-light" href="<%= request.getContextPath() %>/principal/ver-contatos">
																		<i class="ti-headphone-alt mr-2"></i>Ver contatos
																	</a>
																</div>
															</div>
														</div>
                                        			</div>
                                        		</div>
                                        		<div class="col-md-6">
                                        			<div class="card ultimos-ch">
                                        				<div class="card-header">
                                        					<h5 class="card-title">Meus últimos chamados</h5>
                                        				</div>
                                        				<div class="card-body">
	                                        				<table class="table table-hover ultimosCh d-block d-xl-table">
		                                                        <thead>
		                                                            <tr>
		                                                                <th>#</th>
		                                                                <th>Assunto</th>
		                                                                <th>Data</th>
		                                                                <th>Status</th>
		                                                            </tr>
		                                                        </thead>
		                                                        <tbody class="ultimosChtb">
		                                                            
		                                                        </tbody>
		                                                    </table>
                                        				</div>
                                        			</div>
                                        		</div>                                        		
                                        	</c:if>                                   	
                                        </div>
                                        <hr>
                                        <!-- Novidades DIV -->
                                        <h2 class="mb-3">Novidades do sistema</h2>
                                        <div class="row">
											<div class="card-columns">
												<div class="card">
													<img class="card-img-top img-fluid" src="<%= request.getContextPath() %>/assets/images/call-operator-working.jpg" alt="Card image cap">
													<div class="card-body">
														<h5 class="card-title">Profissionais disponíveis para o seu conforto</h5>
														<p class="card-text mt-2">contamos com uma equipe capacitada e treinada para atender às demandas de suporte com agilidade
														 e profissionalismo</p>
													</div>
												</div>
												<div class="card p-3">
													<blockquote class="blockquote mb-0 card-body">
														<p>Sistema feito para o conforto do usuário</p>
														<footer class="blockquote-footer">
															<small class="text-muted"> Andreza B Silva <cite
																title="Source Title">TT Vidros</cite>
															</small>
														</footer>
													</blockquote>
												</div>
												<div class="card text-center">
													<div class="card-body">
														<h5 class="card-title">Aviso no email</h5>
														<p class="card-text">O sistema avisa quando acontecem alterações em seu chamado</p>
														<p class="card-text">
															<small class="text-muted">Atualizado há 10 dias</small>
														</p>
													</div>
												</div>												
												<div class="card p-3 text-right">
													<blockquote class="blockquote mb-0">
														<p class="h4 text-dark">Sistema de relatórios completo para empresas, afim de um maior controle
														de seu negócio</p>
														<footer class="blockquote-footer">
															<small class="text-muted"> Equipe<cite
																title="Source Title"> Meu Suporte </cite>
															</small>
														</footer>
													</blockquote>
												</div>
												<div class="card">
													<div class="card-body">
														<h5 class="card-title">Abra chamados de onde estiver</h5>
														<p class="card-text mt-2">Com um projeto feito para ser acessível em qualquer aparelho,
														O sistema Meu Suporte te dá a oportunidade de comodidade no atendimento no dispositivo
														que achar necessário.</p>
														<p class="card-text">
															<small class="text-muted">Equipe de desenvolvimento</small>
														</p>
													</div>
												</div>
												<div class="card">
													<img class="card-img-top" src="<%= request.getContextPath() %>/assets/images/workspace.jpg" alt="Card image cap">
													<div class="card-body">
														<h5 class="card-title">Novidades em breve</h5>
														<p class="card-text mt-2">O sistema está recebendo melhorias constantes com patchs de correção e 
														atualização, afim de oferecer uma maior gama de funções para você.</p>
														<p class="card-text">
															<small class="text-muted">A gerência</small>
														</p>
													</div>
												</div>												
												<div class="card bg-primary text-white text-center p-3">
													<blockquote class="blockquote mb-0">
														<p class="h4 text-light">Clique <span class="text-info">aqui</span> para fazer de sua empresa
														um negócio com o sistema de suporte apropiado para seus clientes.</p>														
													</blockquote>
												</div>												
											</div>
										</div>
                                    </div>
                                    <!-- Page-body end -->
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Avisos de navegador desatualizado -->
    <jsp:include page="fragments/warnings.jsp"></jsp:include>
    
    <!-- Js -->
    <jsp:include page="fragments/main-javascript.jsp"></jsp:include>
    
    <script type="text/javascript">
    
   	$(document).ready(function(){
   		
   		$(".ultimos-ch").css("max-height", $(".funcoes").height()).css("overflow", "scroll");
   		
   		let perfil = '${perfilUser}';
   		if(perfil=='administrador' || perfil=='colaborador')
   			window.location.href = '<%= request.getContextPath() %>/principal/ver-chamados/';
   			
   		buscaTodosChamados();
   		
   		if(perfil=='cliente')
   			window.setInterval('atualizaPagina()', 15000);
   		
   	});

   	function atualizaPagina(){
   		$(".ultimosChtb").empty();
   		buscaTodosChamados();
   	}
   	
   	function buscaTodosChamados(){
   		$.ajax({
   	   		
   	   		method: 'get',
   	   		url: "<%= request.getContextPath() %>/ServletChamadoController",
   	   		data: "acao=verTodos",
   	   		success: function (response){   	   			
   	   			var jsonResult = JSON.parse(response);   	   			   	   			
   	   			
   	   			for(var i = 0; i < jsonResult.length; i++){
   	   				
   	   				var novaData = new Date(jsonResult[i].criadoEm);
   	   				novaData = novaData.toLocaleString();
   	   				
   	   				let txt = "<tr>";
   	   					txt +="<td>"+jsonResult[i].id+"</td>";
   	   					txt +="<td>"+jsonResult[i].titulo+"</td>";
   	   					txt +="<td class='criadoEm'>"+novaData+"</td>";
   	   					txt +="<td>"+jsonResult[i].status+"</td>";
   	   					txt +="</tr>";   	   				
   	   					
   	   				$(".ultimosCh > tbody").append(txt);
   	   			}
   	   		}   	   		
   	   		
   	   	}).fail(function(xhr, status, errorThrown){
   	   		$.alert('erro ao listar');
   	   	});
   	}
    </script>
</body>
</html>
