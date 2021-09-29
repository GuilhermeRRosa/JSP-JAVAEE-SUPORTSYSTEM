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
                                        	
                                        	<h3>Todos os usuários</h3>
                                        	
                                        	<!-- tabela com os usuários -->
                                        	<table class="table table-sm table-striped">
											  <thead class="thead-dark">
											    <tr>
											      <th scope="col">#Id</th>
											      <th scope="col">Nome</th>
											      <th scope="col">E-mail</th>
											      <th scope="col">Username</th>
											      <th scope="col">Gênero</th>
											      <th scope="col">ações</th>
											    </tr>
											  </thead>
											  <tbody>
											  <c:forEach var="u" items="${allUsers}">
											  	<tr>
											      <th scope="row">${u.id}</th>
											      <td>${u.nome}</td>
											      <td>${u.email}</td>
											      <td>${u.user}</td>
											      <td>${u.genero}</td>
											      <td>
											      	<i class="ti-trash mx-3" onclick="deletar(${u.id})" style="cursor: pointer;"></i>
											      	<i class="ti-pencil" onclick="editar(${u.id})" style="cursor: pointer;"></i>
											      </td>
											    </tr>
											  </c:forEach>
											  	<tr>
											  		<td colspan="6"><strong>Total: <c:out value="${allUsers.size()}"></c:out></strong></td>
											  	</tr>    
											  </tbody>
											</table>
                                        	
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
    function deletar(id){
		$.confirm({
		    title: 'Confirmação!',
		    content: 'Deseja excluir o cadastro de ID = '+id+'?',
		    buttons: {
		        sim: function () {
		        	$.ajax({	
		        		method: "get",
		        		url: "<%= request.getContextPath() %>/ServletUserController",
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
    		        	location.href="<%= request.getContextPath() %>/ServletUserController?acao=editarUser&id="+id;
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
