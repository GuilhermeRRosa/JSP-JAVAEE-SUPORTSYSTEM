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
                                        <div class="row">                     
                                        	<!-- Conteúdo aqui -->                                        	
                                        	<br>
                                        	<hr>
                                        	<div class="col-md-12">
                                        		<div class="card">
												<div class="card-header"><h3>Relatórios de Cliente</h3></div>
												<div class="card-body">
													<p>Selecione o filtro para aplicação</p>
														<form action="<%= request.getContextPath() %>/principal/ver-relatorios/clientes/" method="get">
 															<div class="row row-filtros">
																<div class="col-md-6">
																	<label class="form-label">
																		Filtro
																	</label>
																	<select id="select-filtros" name="filtro" class="form-control">
																		<option id="opt-todos" value="todos">Todos</option>
																		<option id="opt-esp" value="esp">Dados de cliente específico</option>
																	</select>																	
																</div>
																<div class="col-md-2 filtro-todos">
																	<label class="form-label"> Data Inicial </label> <input
																		type="date" id="datepicker" name="dataNascInicial"
																		placeholder="Data nasc. inicial" class="form-control" />
																</div>
																<div class="col-md-2 filtro-todos">
																	<label class="form-label"> Data Final </label> <input
																		type="date" id="datepicker2" name="dataNascFinal"
																		placeholder="Data nasc. final" class="form-control" />
																</div>
																<div class="col-md-2 filtro-todos">
																	<div class="form-check mt-2">
																		<input class="form-check-input m-0 mt-1"
																			type="checkbox" name="gerarPDF" value="gerar"
																			id="defaultCheck1"> <label
																			class="form-check-label" for="defaultCheck1">
																			Gerar PDF </label>
																	</div>
																	<button type="submit" value="Gerar"
																		class="btn btn-primary align-self-end">Gerar
																		relatório</button>
																</div>
															</div>
														</form>
													</div>
												</div>
                                        	</div>
										</div>
										<c:if test="${!empty dados}">
										<div class="row">
											<div class="col-md-12">
                                        		<div class="card">												
													<div class="card-body">
														<div class="table-responsive">
														<h6 class="card-title p-1">resultado da pesquisa</h6>
                                                    	<table class="table table-hover">
	                                                        <thead>
	                                                            <tr>
	                                                                <th>#</th>
	                                                                <th>Nome</th>
	                                                                <th>tipo</th>
	                                                                <th>empresa</th>
	                                                                <th>Data Nasc.</th>
	                                                            </tr>
	                                                        </thead>
	                                                        <tbody class="result">
	                                                        	<c:forEach var="u" items="${dados}">
	                                                            <tr>
	                                                                <th scope="row">${u.id}</th>
	                                                                <td>${u.nome}</td>
	                                                                <td>${u.perfil}</td>
	                                                                <td>${u.empresa.razaoSocial}</td>
	                                                                <td class="dataNasc">${u.dataNasc}</td>
	                                                            </tr>
	                                                            </c:forEach>
	                                                        </tbody>
	                                                    </table>
                                                		</div>
													</div>
												</div>
                                        	</div>
										</div>
										</c:if>
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
    
    <!-- Modal pesquisa usuários -->
    <div class="modal fade" id="pesquisarUserModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Pesquisar usuário</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="input-group mb-3">
			  <input type="text" class="form-control" id="usernamePesquisa" name="username" placeholder="Nome" aria-label="nome de usuário" aria-describedby="basic-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="button" onclick="pesquisaUser()">Pesquisar</button>
			  </div>
			</div>
			<div class="scrollable">
				<table class="table table-sm user-table table-striped">
				  <thead>
				    <tr>
				      <th scope="col">id</th>
				      <th scope="col">Nome</th>
				      <th scope="col">Usuário</th>
				      <th scope="col">Email</th>
				      <th scope="col">ações</th>
				    </tr>
				  </thead>
				  <tbody>
				    
				  </tbody>
				</table>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">fechar</button>
	      </div>
	    </div>
	  </div>
	</div>
    
    <!-- Avisos de navegador desatualizado -->
    <jsp:include page="fragments/warnings.jsp"></jsp:include>
    
    <!-- Js -->
    <jsp:include page="fragments/main-javascript.jsp"></jsp:include>
    <script type="text/javascript"> 
    
    	// Função formata data
	    $(document).ready(function(){
	    	$(".result tr").each(function(){
	    		$(this).find(".dataNasc").each(function(){
	    			let dataNa = new Date($(this).html());
	    			if(dataNa != "Invalid Date"){
		    			$(this).text(dataNa.toLocaleDateString());    				
	    			}else{
	    				$(this).text("Não informado");
	    			}
	    		});
	    	});
	    	
	    	// Alterar filtros
	    	$("#select-filtros").change(function(){
	    		$("#opt-todos:selected").each(function(){
	    			$(".filtro-todos").removeClass("d-none");
	    			$(".input-esp").remove();
	    		});
	    		$("#opt-esp:selected").each(function(){
	    			$(".filtro-todos").addClass("d-none");
	    			$(".row-filtros").append(
	    				 "<div class='col-md-4 input-esp'>"
		    				+"<label class='form-label'>Nome:</label>" 
		    				+"<input type='hidden' name='user-id' id='id'>"
		    				+"<input type='text' name='nome-usuario' id='nome' placeholder='Selecione o usuário' class='form-control' readonly='true'>" 
	    				+"</div>"
	    				+"<div class='col-md-1 input-esp'>"
	    					+"<button type='button' class='btn btn-secondary' data-toggle='modal' data-target='#pesquisarUserModal'>Selecionar</button>"
	    				+"</div>"
	    				+"<div class='col-md-1 input-esp'>"
    						+"<button type='submit' class='btn btn-primary'>Gerar</button>"
    					+"</div>"
	    			);
	    		});
	    	});
	    }); 
    	
	    function selectUser(obj){
    		$("#pesquisarUserModal").modal('hide');
    		$(obj).each(function(index, element) {
    		  $("#id").attr('value', element.id);
    		  $("#nome").attr('value', element.nome);
    		});
    	}
    	
	    function pesquisaUser(){
    		var userP = $("#usernamePesquisa").val();
    		
    		if(userP !=null && userP != "" && userP.trim() != ""){
    			var urlAction = "<%= request.getContextPath() %>/ServletUserController";
            	
	        	$.ajax({
	        		
	        		method: "get",
	        		url: urlAction,
	        		data: "nomeP="+userP+"&acao=buscarComAjax",
	        		success: function (response){
	        			
	        			$(".modal-dialog").css({
	        				'max-width': $(document).width() * 0.5
	        			});
	        			
	        			$(".scrollable")
	        				.css({
	        					'max-height': '38em',
								'overflow': 'scroll'
							});
	        			
						var jsonResult = JSON.parse(response);
						
						$(".user-table > tbody > tr").remove();
						
						for(var i = 0; i < jsonResult.length; i++){
							
							var user = JSON.stringify(jsonResult[i]);
							var txt = '<tr>';
							txt += '<td>'+jsonResult[i].id+'</td>';
							txt += '<td>'+jsonResult[i].nome+'</td>';
							txt += '<td>'+jsonResult[i].user+'</td>';
							txt += '<td>'+jsonResult[i].email+'</td>';
							txt += "<td><button onclick='selectUser("+user+")' type='button' class='btn btn-secondary btn-sm'>Selecionar</button></td>";
							txt += '</tr>';
							
							$(".user-table > tbody").append(txt);
						}
	        			
	        		}
	        		
	        	}).fail(function(xhr, status, errorThrown){
	        		$.alert({
	        		    title: 'ERRO!',
	        		    content: 'erro ao buscar por nome: '+xhr.textResponse
	        		});
	        	});
    		}
    	}
    </script>
</body>
</html>
