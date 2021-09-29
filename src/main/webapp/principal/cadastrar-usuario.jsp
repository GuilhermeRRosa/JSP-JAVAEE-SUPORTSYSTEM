<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Projeto JSP</title>
    <!-- custom CSS -->
    <link href="<%= request.getContextPath() %>/css/cadastro-usuario.css" type="text/css" rel="stylesheet" />
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
                                        	<div class="col-md-12 shadow">
                                        		<div class="card">
                                        			<div class="card-header">
                                                        <h5>Formulário de usuários</h5>
                                                    </div>
                                                    <div class="alert alert-info text-center" role="alert">
														<span id="msg">
															${msg}
														</span>
													</div>
                                        			<div class="card-block">
                                        				<form action="<%= request.getContextPath() %>/ServletUserController" method="post" class="form-material" id="form-user">
                                        					<!-- INPUT DE DELEÇÃO -->
                                        					<input type="hidden" name="acao" value="" id="acao" />
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="id" id="id" class="form-control" value="${userDto.id}" placeholder="Aqui vai o id" required="required" readonly="readonly">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Id</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="nome" id="nome" class="form-control" value="${userDto.nome}" placeholder="Digite o seu nome" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Nome completo</label>
                                        					</div>
                                        					<div class="form-group">
                                        						<label class="form-label">Gênero: </label>
                                        						<br>
                                        						<input type="radio" name="genero" id="sexo-m" value="masculino" required="required" ${userDto.genero=='masculino' ? 'checked' : ''}> Masculino
                                        						<input type="radio" name="genero" id="sexo-f" value="feminino" required="required" <c:if test="${userDto.genero=='feminino'}">checked</c:if>> Feminino
                                        						<input type="radio" name="genero" id="sexo-o" value="outros" required="required" ${userDto.genero=='outros' ? 'checked' : ''}> Outros
                                        						<span class="form-bar"></span>
                                        					</div>
                                        					<hr>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="email" name="email" id="email" class="form-control" value="${userDto.email}" placeholder="Digite o seu e-mail" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">email</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                                                 <select name="admin" id="isadmin" class="form-control" required>
                                                                     <option value="" ${userDto.admin == null ? 'disabled selected hidden' : ''}>Selecione o perfil de usuário</option>
                                                                     <option value="true" ${userDto.admin == true ? 'selected' : ''}>Admin</option>
                                                                     <option value="false" ${userDto.admin == false ? 'selected' : ''}>Auxiliar</option>
                                                                 </select>
                                                                 <span class="form-bar"></span>
                                        						<label class="float-label">Perfil</label>
                                        					</div>
                                        					<!-- <div class="form-group form-default form-static-label">
                                        						<img alt="img perfil" id="img64" src="" width="70px" class="my-2 img-fluid">
                                        						<input type="file" name="userImage" id="fileImg" accept="image/*" onchange="vizualizaImg('img64', 'fileImg')" class="form-control my-2" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Foto de perfil</label>
                                        					</div> -->
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="user" id="user" class="form-control" value="${userDto.user}" placeholder="Digite o seu nick" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Nome de usuário</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="password" name="password" id="password" class="form-control" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Senha</label>
                                        					</div>
                                        					<div class="d-flex flex-row-reverse">
                                        						<button type="submit" class="btn btn-primary waves-effect waves-light">Salvar</button>
                                        						<button type="reset" onclick="limpaForm()" id="btn-limpaTela"  class="btn btn-warning waves-effect waves-light mx-2">Novo</button>
                                        						<button type="button" onclick="deletarComAjax()" class="btn btn-danger waves-effect waves-light mx-2">Remover</button>
																<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#pesquisarUserModal">Pesquisar</button>
                                        					</div>
                                        				</form>
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
    
     <!-- Modal -->
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
				<table class="table table-sm">
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
    
    <!-- Funcões -->
    <script type="text/javascript">
    	
    	/* function deletar(){
    		document.getElementById("form-user").method = 'get';
    		document.getElementById("acao").value = 'excluirUser';
    		document.getElementById("form-user").submit;
    	} */
    	
    	$(".alert-info").hide();
    	
    	var msg_0 = $("#msg").html();
     	
    	if(msg_0 != null && msg_0.trim().length > 0){
    		$(".alert-info").show();
    	}
    	
    	function showMsg(msg){
    		$(".alert-info").show();
    		$("#msg").text(msg);
    	}
    	
    	function limpaForm(){
    		$.confirm({
    		    title: 'Confirmação!',
    		    content: 'Deseja limpar os campos do formulário?',
    		    buttons: {
    		        sim: function () {
    		        	  $("#id").attr('value', "");
    		    		  $("#nome").attr('value', "");
    		    		  $("#email").attr('value', "");
    		    		  $("#user").attr('value', "");
    		    		  $("#password").attr('value', "");
    		    		  $("#isadmin").attr('value', "");
    		    		  showMsg('Formulário limpo!');
    		        },
    		        não: function () {
    		            $.alert('Ação cancelada!');
    		        },   
    		    }
    		});	
    	}
    	
    	function selectUser(obj){
    		$("#pesquisarUserModal").modal('hide');
    		$(obj).each(function(index, element) {
    		  $("#id").attr('value', element.id);
    		  $("#nome").attr('value', element.nome);
    		  $("#email").attr('value', element.email);
    		  $("#user").attr('value', element.user);  
    		  $("#isadmin").attr('value', element.admin);
    		  switch(element.genero){
    		  	case 'masculino': $("#sexo-m").prop('checked', true);
    		  		break;
    		  	case 'feminino': $("#sexo-f").prop('checked', true);
    		  		break;
    		  	case 'outros': $("#sexo-o").prop('checked', true);
    		  		break;
    		  }
    		});
    	}
    	
    	function pesquisaUser(){
    		var userP = $("#usernamePesquisa").val();
    		
    		if(userP !=null && userP != "" && userP.trim() != ""){
    			var urlAction = $("#form-user").attr("action");
            	
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
						
						$(".table-sm > tbody > tr").remove();
						
						for(var i = 0; i < jsonResult.length; i++){
							
							var user = JSON.stringify(jsonResult[i]);
							var txt = '<tr>';
							txt += '<td>'+jsonResult[i].id+'</td>';
							txt += '<td>'+jsonResult[i].nome+'</td>';
							txt += '<td>'+jsonResult[i].user+'</td>';
							txt += '<td>'+jsonResult[i].email+'</td>';
							txt += "<td><button onclick='selectUser("+user+")' type='button' class='btn btn-secondary'>Selecionar</button></td>";
							txt += '</tr>';
							
							$(".table-sm > tbody").append(txt);
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
    	
   		function deletar(){
    		$.confirm({
    		    title: 'Confirmação!',
    		    content: 'Deseja excluir o cadastro atual?',
    		    buttons: {
    		        sim: function () {
    		        	$("#form-user").attr("method", "get");
    	    			$("#acao").attr("value", "excluirUser");
    	    			$("#form-user").submit();
    		        },
    		        não: function () {
    		            $.alert('Ação cancelada!');
    		        },   
    		    }
    		});	
   		}
    	
    	function deletarComAjax(){
    		
    		var idUser = $("#id").attr("value");
    		
    		if(idUser == null || idUser == ""){
    			showMsg("Nenhum dado informado!");
    		}else{
    			$.confirm({
        		    title: 'Confirmação!',
        		    content: 'Deseja excluir o cadastro atual?',
        		    buttons: {
        		        sim: function () {
        		        	
        		        	var urlAction = $("#form-user").attr("action");
        	
        		        	$.ajax({
        		        		
        		        		method: "get",
        		        		url: urlAction,
        		        		data: "id="+idUser+"&acao=deletarComAjax",
        		        		success: function (response){
        		        			$("#id").attr('value', "");
        	    		    		$("#nome").attr('value', "");
        	    		    		$("#email").attr('value', "");
        	    		    		$("#user").attr('value', "");
        	    		    		$("#password").attr('value', "");
        		        			
        		        			showMsg(response);
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
    		
    	}
    	
    	function vizualizaImg(img64, fileImg){
    		
    		var preview = document.getElementById("img64");
    		var fileUser = document.getElementById("fileImg").files[0];
    		var reader = new FileReader();
    		
    		reader.onloadend = function(){
    			preview.src = reader.result;
    		};
    		
    		if (fileUser){
    			reader.readAsDataURL(fileUser);
    		}else{
    			preview.src = '';
    		}
    	}
    
    </script>
</body>
</html>