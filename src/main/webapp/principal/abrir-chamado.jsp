<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">

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
                                                        <h5>Cadastrar chamado</h5>
                                                    </div>
                                                    <div class="alert alert-info text-center" role="alert">
														<span id="msg">
															${msg}
														</span>
													</div>
                                        			<div class="card-block">
                                        				<form action="<%= request.getContextPath() %>/ServletChamadoController" method="post" class="form-material" id="form-user">
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="titulo" id="titulo" class="form-control" value="${userDto.nome}" placeholder="Digite o assunto da chamada" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Assunto</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<textarea class="form-control" id="summernote" name="descricao" required="required"></textarea>
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Descrição</label>
                                        					</div>
                                        					<div class="d-flex flex-row-reverse">
                                        						<button type="submit" class="btn btn-primary waves-effect waves-light">Enviar</button>
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
	
	<!-- Modal -->
	<div class="modal fade" id="pesquisarEmpresaModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modalEmpresa">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Pesquisar empresa</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="input-group mb-3">
			  <input type="text" class="form-control" id="empresaPesquisa" name="razaoSocial" placeholder="Razão Social" aria-label="Razão Social" aria-describedby="basic-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="button" onclick="pesquisaEmpresa()">Pesquisar</button>
			  </div>
			</div>
			<div class="scrollable">
				<table class="table emp-table table-sm table-striped">
				  <thead>
				    <tr>
				      <th scope="col">id</th>
				      <th scope="col">Razão Social</th>
				      <th scope="col">CNPJ</th>
				      <th scope="col">Telefone</th>
				      <th scope="col">representante</th>
				      <th scope="col">Ação</th>
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
    	
    	$(document).ready(function(){
    		$('#summernote').summernote({
    			height: 100
    		});
    	})
    	
    	$(".alert-info").hide();
    	
    	var msg_0 = $("#msg").html();
     	
    	if(msg_0 != null && msg_0.trim().length > 0){
    		$(".alert-info").show();
    	}
    	
    	//Alternador de "selecionar empresa"
    	$("#perfil").change(function(){
    		if($(this).val()=="colaborador" || $(this).val()=="administrador"){
        		$("#div-select-empresa").addClass("d-none");
        		$("#nomeEmpresa").val('${empresaUserSessionNome}');
        		$("#empresa").val('${empresaUserSession}');
        	}else{
        		$("#div-select-empresa").removeClass("d-none");
        	}
    	})
    	
    	function showMsg(msg){
    		$(".alert-info").show();
    		$("#msg").text(msg);
    	}
    	
    	function acaoForm(){
    		if($("#id").val != null){
	    		event.preventDefault();
	    		$.confirm({
	    		    title: 'Cadastro de telefones.',
	    		    content: 'Deseja cadastrar os telefones para este usuário agora?',
	    		    buttons: {
	    		        sim: function () {
	    		        	$("#form-user").removeAttr("onsubmit");
	    		        	
	    		        	$("#acao").val("cadastraTelefones")
	    		        	
	    		        	$("#form-user").trigger( "submit" );
	    		        },
	    		        não: function () {
	    		        	$("#form-user").removeAttr("onsubmit");
	    		            $("#form-user").trigger( "submit" );
	    		        },   
	    		    }
	    		});
    		}else{
    			$("#form-user").removeAttr("onsubmit");
	            $("#form-user").trigger( "submit" );
    		}
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
    		    		  $("#perfil").attr('value', "");
    		    		  $("#cep").attr('value', "");
    		    		  $("#logradouro").attr('value', "");
    		    		  $("#cidade").attr('value', "");
    		    		  $("#bairro").attr('value', "");
    		    		  $("#uf").attr('value', "");
    		    		  $("#genero").attr('value', "");
    		    		  $("#userImage").attr('value', "");
    		    		  $("#img64").attr('src', "<%=request.getContextPath()%>/principal/files-upload/default/profile.png");
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
    		  $("#perfil").attr('value', element.perfil);
    		  $("#cep").attr('value', element.cep);
    		  $("#logradouro").attr('value', element.logradouro);
    		  $("#cidade").attr('value', element.cidade);
    		  $("#bairro").attr('value', element.bairro);
    		  $("#uf").attr('value', element.uf);
    		  $("#userImage").attr('value', "");
    		  $("#img64").attr('src', element.userImage);
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
    	
    	function pesquisaEmpresa(){
    		var userP = $("#empresaPesquisa").val();
    		
    		if(userP !=null && userP != "" && userP.trim() != ""){
    			var urlAction = "<%= request.getContextPath() %>/ServletEmpresaController";
            	
	        	$.ajax({
	        		
	        		method: "get",
	        		url: urlAction,
	        		data: "razaoSocial="+userP+"&acao=buscarComAjax",
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
						
						$(".emp-table > tbody > tr").remove();
						
						for(var i = 0; i < jsonResult.length; i++){
							
							var emp = JSON.stringify(jsonResult[i]);
							var txt = '<tr>';
							txt += '<td>'+jsonResult[i].id+'</td>';
							txt += '<td>'+jsonResult[i].razaoSocial+'</td>';
							txt += '<td>'+jsonResult[i].cnpj+'</td>';
							txt += '<td>'+jsonResult[i].telefone+'</td>';
							txt += '<td>'+jsonResult[i].representante.nome+'</td>';
							txt += "<td><button onclick='selectEmpresa("+emp+")' type='button' class='btn btn-secondary btn-sm'>Selecionar</button></td>";
							txt += '</tr>';
							
							$(".emp-table > tbody").append(txt);
						}
	        			
	        		}
	        		
	        	}).fail(function(xhr, status, errorThrown){
	        		$.alert({
	        		    title: 'ERRO!',
	        		    content: 'erro ao buscar por razão social: '+xhr.textResponse
	        		});
	        	});
    		}
    	}
    	
    	function selectEmpresa(obj){
    		$("#pesquisarEmpresaModal").modal('hide');
    		$(obj).each(function(index, element) {
    		  $("#nomeEmpresa").val(element.razaoSocial);
    		  $("#empresa").val(element.id);
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
    	
    	//Quando o campo cep perde o foco.
    	$("#cep").blur(function() {

    	    //Nova variável "cep" somente com dígitos.
    	    var cep = $(this).val().replace(/\D/g, '');

    	    //Verifica se campo cep possui valor informado.
    	    if (cep != "") {

    	        //Expressão regular para validar o CEP.
    	        var validacep = /^[0-9]{8}$/;

    	        //Valida o formato do CEP.
    	        if(validacep.test(cep)) {

    	            //Preenche os campos com "..." enquanto consulta webservice.
    	            $("#rua").val("...");
    	            $("#bairro").val("...");
    	            $("#cidade").val("...");
    	            $("#uf").val("...");
    	            $("#ibge").val("...");

    	            //Consulta o webservice viacep.com.br/
    	            $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

    	                if (!("erro" in dados)) {
    	                    //Atualiza os campos com os valores da consulta.
    	                    $("#logradouro").val(dados.logradouro);
    	                    $("#bairro").val(dados.bairro);
    	                    $("#cidade").val(dados.localidade);
    	                    $("#uf").val(dados.uf);
    	                } //end if.
    	                else {
    	                    //CEP pesquisado não foi encontrado.
    	                    limpa_formulário_cep();
    	                    alert("CEP não encontrado.");
    	                }
    	            });
    	        } //end if.
    	        else {
    	            //cep é inválido.
    	            alert("Formato de CEP inválido.");
    	        }
    	    } //end if.
    	    else {
    	        //cep sem valor, limpa formulário.
    	        limpa_formulário_cep();
    	    }
    	});
    
    </script>
</body>
</html>