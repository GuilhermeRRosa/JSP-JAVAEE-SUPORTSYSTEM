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
  <!-- Loading da p�gina -->
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
                                        	<!-- Conte�do aqui -->
                                        	<div class="col-md-12 shadow">
                                        		<a href="${chamado.status == 'concluido' ? 'principal/ver-concluidos' : 'principal/ver-chamados/'}" class="btn btn-primary mb-2 mx-2">Voltar</a>
                                        		<div class="card">
                                        			<div class="card-header rounded border border-secondary m-3">
                                                        <h5>Detakhes do chamado</h5>
                                                        <hr>
                                                        <table class="w-100">
                                                        	<tbody>
	                                                        	<tr>
	                                                        		<td><p><strong>Chamado:</strong> ${chamado.titulo}</p></td>
	                                                        		<td><p><strong>Usu�rio:</strong> ${chamado.cliente.nome}</p></td>                                                        		
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
                                       					<h5>Descri��o:</h5>
                                       					<hr>
                                       					<span>${chamado.descricao}</span>
                                        			</div>
                                        			<div class="card-block rounded border border-secondary m-3">
                                       					<h5>resposta:</h5>
                                       					<hr>
                                       					<span>${chamado.resposta}</span>
                                       					<c:out value="${chamado.resposta == null ? 'ainda n�o h� respostas para este chamado' : ''}"></c:out>                                       					                                  						
                                        			</div>
                                        		</div>
                                        		<!-- Action buttons -->
                                        		<c:if test="${chamado.status!='concluido'}">
                                        			<c:if test="${perfilUser=='administrador' || perfilUser=='colaborador'}">
	                                        		<div class="d-flex flex-row-reverse mt-1 mx-3">
	                                        			<!-- Button trigger modal -->
														<button type="button" class="btn btn-success mx-1" data-toggle="modal" data-target="#exampleModalCenter" data-idChamado="${chamado.id}">
														  Responder
														</button>
	                                        			<a onclick="alteraStatus(${chamado.id}, 'Em atendimento')" class="btn btn-warning mx-1 text-dark">Em antendimento</a>
	                                        			<a onclick="alteraStatus(${chamado.id}, 'pendencia')" class="btn btn-danger mx-1">Pend�ncia</a>
	                                        		</div>
                                        			</c:if>
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
    
    <!-- Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">Responder chamado</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="formResponse">
	        	<input type="hidden" value="" name="idChamado" id="idChamado">
	        	<textarea class="form-control" id="summernote" name="resposta" required="required"></textarea>
	        	<div class="d-flex flex-row-reverse mt-1">
		       	 	<button type="button" onclick="responderChamado()" class="btn btn-success mx-1">Responder e Concluir</button>
		        	<button type="button" class="btn btn-secondary mx-1" data-dismiss="modal">fechar</button>
	        	</div>
	        </form>
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
    		
    		$('#summernote').summernote({
    			height: 100
    		});
    		
    		var criadoEm = new Date($(".criadoEm").html());
    		
    		$(".criadoEm").text(criadoEm.toLocaleString());
	
    	});
    	
    	function responderChamado(){   		
    		
    		var resposta = $('#summernote').val();
    		var chamadoId = ${chamado.id};
    		
    		$.post("<%= request.getContextPath() %>/ServletChamadoController", {chamadoId: chamadoId, resposta: resposta, acao: 'responderChamado'})
    			.done(function(response){
    				location.reload();
    			})
    	}
    	
    	function alteraStatus(id, status){
    		
    		var statusAtual = '${chamado.status}';
    		
    		if(status==statusAtual){
    			$.alert("Chamado j� esta no modo: "+status);
    		}else{
    			$.get("<%= request.getContextPath() %>/ServletChamadoController", { chamadoId: id, status: status, acao: 'alteraStatus'})
    			.done(function(response){
    				$.confirm({
        			    title: 'A��o executada!',
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
