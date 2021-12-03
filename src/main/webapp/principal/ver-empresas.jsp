<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
                                        	
                                        	<h3>Todos as empresas</h3>
                                        	
                                        	<!-- tabela com os usuários -->
                                        	<table class="table table-sm table-striped">
											  <thead class="thead-dark">
											    <tr>
											      <th scope="col">#Id</th>
											      <th scope="col">Razão Social</th>
											      <th scope="col">E-mail</th>
											      <th scope="col">Representante</th>
											      <th scope="col">Telefone</th>
											      <c:if test="${perfilUser=='admin' || perfilUser=='administrador'}">
											      	<th scope="col">ações</th>
											      </c:if>
											    </tr>
											  </thead>
											  <tbody>								  
											  	<tr>
											  		<td colspan="6"><strong>Total: <c:out value="${totalUsers}"></c:out></strong></td>
											  	</tr>    
											  </tbody>
											</table>
											<nav aria-label="..." class="mx-auto">
												<ul class="pagination">
												</ul>
											</nav>
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
    	paginationAjax(0);	   	
    });
    
    function paginationAjax(pag){
    	
    	var perfilUser = '${perfilUSer}';
    	var isAdmin = false;
    	if(perfilUser=='admin' || perfilUser=='administrador'){
    		isAdmin=true;
    	}
    	
    	$.ajax({	
    		method: "get",
    		url: "<%= request.getContextPath() %>/ServletEmpresaController",
    		data: "pag="+pag+"&acao=listarComAjax",
    		success: function (response){

    			var jsonResult = JSON.parse(response);
				
				$(".table-sm > tbody > tr").remove();
				
				for(var i = 0; i < jsonResult.length; i++){
					
					var txt = '<tr>';
					txt += '<td>'+jsonResult[i].id+'</td>';
					txt += '<td>'+jsonResult[i].razaoSocial+'</td>';
					txt += '<td>'+jsonResult[i].email+'</td>';
					txt += '<td>'+jsonResult[i].representante.nome+'</td>';
					txt += '<td>'+jsonResult[i].telefone+'</td>';
					txt += '<td>';
					if(isAdmin){
						txt += "<i class='ti-pencil' onclick='editar("+jsonResult[i].id+")' style='cursor: pointer;'></i>";
						txt += "<i class='ti-trash mx-3' onclick='deletar("+jsonResult[i].id+")' style='cursor: pointer;'></i>";
					}
					txt += '</td>';
					txt += '</tr>';
					
					$(".table-sm > tbody").append(txt);	
				}
				var lastLine = '<tr><td colspan="6"><strong>Total: <c:out value="${totalUsers}"></c:out></strong></td>';
				
				$(".table-sm > tbody").append(lastLine);
    		}	        		
    	}).fail(function(xhr, status, errorThrown){
    		$.alert({
    		    title: 'ERRO!',
    		    content: 'erro ao listar empresas: '+xhr.textResponse
    		});
    	});
    }
    
    function deletar(id){
		$.confirm({
		    title: 'Confirmação!',
		    content: 'Deseja excluir o cadastro de ID = '+id+'?',
		    buttons: {
		        sim: function () {
		        	$.ajax({	
		        		method: "get",
		        		url: "<%= request.getContextPath() %>/ServletEmpresaController",
		        		data: "id="+id+"&acao=deletarComAjax",
		        		success: function (response){
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
		        		}	        		
		        	}).fail(function(xhr, status, errorThrown){
		        		$.alert({
		        		    title: 'ERRO!',
		        		    content: 'erro ao deletar por id: '+xhr.textResponse
		        		});
		        	});
		        },
		        não: function () {
		            $.alert('Ação cancelada!');
		        },   
		    }
		});	
		}
    
    	function editar(id){
    		$.confirm({
    		    title: 'Confirmação!',
    		    content: 'Deseja editar o cadastro de ID = '+id+'?',
    		    buttons: {
    		        sim: function () {
    		        	location.href="<%= request.getContextPath() %>/ServletEmpresaController?acao=editarEmpresa&id="+id;
    		        },
    		        não: function () {
    		            $.alert('Ação cancelada!');
    		        },   
    		    }
    		});	
    	}
    	
		var nPaginas = ${totalPaginas};
    	
    	for(p = 0; p < nPaginas; p++){
    		$('.pagination').append('<li class="page-item"><a class="page-link" onclick="paginationAjax('+p+')" style="cursor: pointer;">'+(p+1)+'</a></li>');
    	} 
    </script>
</body>
</html>
