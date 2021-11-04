<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
                                        <div class="row">                     
                                        	<!-- Conteúdo aqui -->
                                        	<div class="col-md-12">
                                        	<div class="card table-card">
                                                    <div class="card-header bg-dark">
                                                        <h5 class="text-light">Chamados Abertos</h5>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
                                                                <li><i class="fa fa-minus minimize-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <c:if test="${!empty chamadosAbertos}">
                                                          <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                <tr>
                                                                    <th>Assunto</th>
                                                                    <th>Criado por</th>
                                                                    <th>Criado em</th>
                                                                    <th class="text-right">Status</th>
                                                                    <th class="text-right">Ações</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody class="chamados">
                                                                <c:forEach var="chamado" items="${chamadosAbertos}">
                                                                <tr>
                                                                    <td><h6>${chamado.titulo}</h6></td>
                                                                    <td>${chamado.cliente.nome}</td>
                                                                    <td><span class="criadoEm">${chamado.criadoEm}</span></td>
                                                                    <td class="text-right"><label class="label label-danger">${chamado.status}</label></td>
                                                                    <td class="text-right">
                                                                    	<a onclick="confirmaExclusao(${chamado.id})" data-toggle="tooltip" data-placement="left" data-trigger="hover" title="Deletar chamado">
                                                                    		<i class="ti-trash mr-2"></i>
                                                                    	</a> 	
                                                                    	<a href="<%= request.getContextPath() %>/ServletChamadoController?acao=verChamado&id=${chamado.id}" class="btn btn-info text-light">ver</a>
                                                                    </td>
                                                                </tr>
                                                                </c:forEach>
                                                                </tbody>
                                                            </table>
                                                       	  </div>
                                                        </c:if>
                                                        <c:if test="${empty chamadosAbertos}">
                                                      	<div>
                                                      		<p>
                                                      			<h6  class="m-3">Não há atendimentos nesta seção</h6>
                                                      		</p>
                                                      	</div>
                                                      </c:if>
                                                    </div>
                                                </div>
                                        	</div>
                                        	
                                        	<!-- Chamados em Atendimento -->
                                        	<div class="col-md-12">
                                        	<div class="card table-card">
                                                    <div class="card-header bg-warning">
                                                        <h5>Chamados em atendimento</h5>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
                                                                <li><i class="fa fa-minus minimize-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                      <c:if test="${!empty chamadosEmAtendimento}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                <tr>
                                                                    <th>Assunto</th>
                                                                    <th>Atendido por</th>
                                                                    <th>Criado por</th>
                                                                    <th>Criado em</th>
                                                                    <th class="text-right">Status</th>
                                                                    <th class="text-right">Ações</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody class="chamados">
                                                                <c:forEach var="chamado" items="${chamadosEmAtendimento}">
                                                                <tr>
                                                                    <td><h6>${chamado.titulo}</h6></td>
                                                                    <td>${chamado.atentidoPor.nome}</td>
                                                                    <td>${chamado.cliente.nome}</td>
                                                                    <td><span class="criadoEm">${chamado.criadoEm}</span></td>
                                                                    <td class="text-right"><label class="label label-danger">${chamado.status}</label></td>
                                                                    <td class="text-right">
                                                                    	<a onclick="confirmaExclusao(${chamado.id})" data-toggle="tooltip" data-placement="left" data-trigger="hover" title="Deletar chamado">
                                                                    		<i class="ti-trash mr-2"></i>
                                                                    	</a> 	
                                                                    	<a href="<%= request.getContextPath() %>/ServletChamadoController?acao=verChamado&id=${chamado.id}" class="btn btn-info text-light">ver</a>
                                                                    </td>
                                                                </tr>
                                                                </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                      </c:if>
                                                      <c:if test="${empty chamadosEmAtendimento}">
                                                      	<div>
                                                      		<p>
                                                      			<h6  class="m-3">Não há atendimentos nesta seção</h6>
                                                      		</p>
                                                      	</div>
                                                      </c:if>
                                                    </div>
                                                </div>
                                        	</div>
                                        	
                                        	<!-- Chamados em Pendência -->
                                        	<div class="col-md-12">
                                        	<div class="card table-card">
                                                    <div class="card-header bg-danger">
                                                        <h5 class="text-light">Chamados em Pendência</h5>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
                                                                <li><i class="fa fa-minus minimize-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                      <c:if test="${!empty chamadosEmPendencia}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                <tr>
                                                                    <th>Assunto</th>
                                                                    <th>Atendido por</th>
                                                                    <th>Criado por</th>
                                                                    <th>Criado em</th>
                                                                    <th class="text-right">Status</th>
                                                                    <th class="text-right">Ações</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody class="chamados">
                                                                <c:forEach var="chamado" items="${chamadosEmPendencia}">
                                                                <tr>
                                                                    <td><h6>${chamado.titulo}</h6></td>
                                                                    <td>${chamado.atentidoPor.nome}</td>
                                                                    <td>${chamado.cliente.nome}</td>
                                                                    <td><span class="criadoEm">${chamado.criadoEm}</span></td>
                                                                    <td class="text-right"><label class="label label-danger">${chamado.status}</label></td>
                                                                    <td class="text-right">
                                                                    	<a onclick="confirmaExclusao(${chamado.id})" data-toggle="tooltip" data-placement="left" data-trigger="hover" title="Deletar chamado">
                                                                    		<i class="ti-trash mr-2"></i>
                                                                    	</a> 	
                                                                    	<a href="<%= request.getContextPath() %>/ServletChamadoController?acao=verChamado&id=${chamado.id}" class="btn btn-info text-light">ver</a>
                                                                    </td>
                                                                </tr>
                                                                </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                      </c:if>
                                                      <c:if test="${empty chamadosEmPendencia}">
                                                      	<div>
                                                      		<p>
                                                      			<h6  class="m-3">Não há atendimentos nesta seção</h6>
                                                      		</p>
                                                      	</div>
                                                      </c:if>
                                                    </div>
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
    		
    		$(".chamados tr").each(function(){
    			$(this).find(".criadoEm").each(function (){
    				var criadoEm = new Date($(this).html());
    				
    				$(this).text(criadoEm.toLocaleString());
    			});
    		});
    		
    	});
    
    	function confirmaExclusao(idc){
    		$.confirm({
    		    title: 'Confirmação!',
    		    content: 'Deseja excluir o chamado atual?',
    		    buttons: {
    		        sim: function () {
    		        	$.get("<%= request.getContextPath() %>/ServletChamadoController", {acao: "deletarAjax", id: idc})
    		        	.done(function (response){
    		        		$.confirm({
		        			    title: 'Ação executada!',
		        			    content: response,
		        			    autoClose: 'ok|3000',
		        			    buttons: {
		        			        ok: function () {
		        			           location.reload();
		        			        }
		        			    }
		        			});	
    		        	});
    		        },
    		        não: function () {
    		            $.alert('Ação cancelada!');
    		        },   
    		    }
    		});	
    	}
    </script>
</body>
</html>
