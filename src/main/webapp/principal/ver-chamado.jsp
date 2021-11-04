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
                                        	<div class="col-md-12 shadow">
                                        		<a href="<%= request.getContextPath() %>/principal/ver-chamados/" class="btn btn-primary m-3">Voltar</a>
                                        		<div class="card">
                                        			<div class="card-header rounded border border-secondary m-3">
                                                        <h5>Detakhes do chamado</h5>
                                                        <hr>
                                                        <table class="w-100">
                                                        	<tbody>
	                                                        	<tr>
	                                                        		<td><p><strong>Chamado:</strong> ${chamado.titulo}</p></td>
	                                                        		<td><p><strong>Usuário:</strong> ${chamado.cliente.nome}</p></td>                                                        		
	                                                        	</tr>
	                                                        	<tr>
	                                                        		<td><p><strong>Empresa:</strong> ${chamado.empresaCliente.razaoSocial}</p></td>
	                                                        		<td><p><strong>Criado em:</strong><span class="criadoEm">${chamado.criadoEm}</span></p></td>                                                        		
	                                                        	</tr>
	                                                        	<tr>
	                                                        		<td colspan="2"><p><strong>Status:</strong> ${chamado.status}</p></td>
	                                                        	</tr>
	                                                        </tbody>
                                                        </table>
                                                    </div>
                                        			<div class="card-block rounded border border-secondary m-3">
                                       					<h5>Descrição:</h5>
                                       					<hr>
                                       					<span>${chamado.descricao}</span>
                                        			</div>
                                        			<div class="card-block rounded border border-secondary m-3">
                                       					<h5>resposta:</h5>
                                       					<hr>
                                       					<c:out value="${chamado.resposta !=null ? chamado.resposta : 'ainda não há respostas para este chamado'}"></c:out>                                       					                                  						
                                        			</div>
                                        		</div>
                                        		<!-- Action buttons -->
                                        		<c:if test="${perfilUser=='administrador' || perfilUser=='colaborador'}">
	                                        		<div class="d-flex flex-row-reverse mt-1 mx-3">
	                                        			<a onclick="" class="btn btn-success mx-1">Responder</a>
	                                        			<a onclick="alteraStatus(${chamado.id}, 'Em atendimento')" class="btn btn-warning mx-1 text-dark">Em antendimento</a>
	                                        			<a onclick="alteraStatus(${chamado.id}, 'pendencia')" class="btn btn-danger mx-1">Pendência</a>
	                                        		</div>
                                        		</c:if>
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
    		
    		var criadoEm = new Date($(".criadoEm").html());
    		
    		$(".criadoEm").text(criadoEm.toLocaleString());
    		
    	});
    	
    	function alteraStatus(id, status){
    		
    		var statusAtual = '${chamado.status}';
    		
    		if(status==statusAtual){
    			$.alert("Chamado já esta no modo: "+status);
    		}else{
    			$.get("<%= request.getContextPath() %>/ServletChamadoController", { chamadoId: id, status: status, acao: 'alteraStatus'})
    			.done(function(response){
    				$.confirm({
        			    title: 'Ação executada!',
        			    content: 'Status alterado com sucesso',
        			    autoClose: 'ok|3000',
        			    buttons: {
        			        ok: function () {
        			           location.reload();
        			        }
        			    }
        			});
    			})
    			.fail(function(){
    				$.alert('Erro no processamento de dados');
    			})
    		} 		
    	}
    </script>
</body>
</html>
