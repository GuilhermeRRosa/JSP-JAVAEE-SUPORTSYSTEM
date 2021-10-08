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
                                        	<div class="col col-md-6">
	                                        	<table class="table table-sm table-striped">
												  <thead class="thead-dark">
												    <tr>
												      <th scope="col">Nome</th>
												      <th scope="col">Username</th>
												      <th scope="col">ações</th>
												    </tr>
												  </thead>
												  <tbody>								  
												  	   
												  </tbody>
												</table>
												<nav aria-label="..." class="w-100 d-flex ">
													<ul class="pagination mx-auto">
													</ul>
												</nav>
											</div>
                                        	<div class="col col-md-6 d-flex flex-column">
                                        		<div class="border border-secondary rounded shadow p-2">
                                        			<div class="row form-group">
                                        				<div class="col-md-6">
                                        					<label class="form-label" for="nome">Nome:</label>
                                        					<input type="text" value="${userDto.nome}" name="nome" class="form-control" id="nome" readonly="readonly" >
                                        				</div>
                                        				<div class="col-md-6">
                                        					<label class="form-label" for="username">Usuário:</label>
                                        					<input type="text" value="${userDto.user}" name="username" class="form-control" id="username" readonly="readonly" >
                                        				</div>
                                        			</div>
                                        			<label class="form-label" for="email">E-mail:</label>
                                        			<input type="text" value="${userDto.email}" name="email" class="form-control " id="email" readonly="readonly" >
                                        			<label class="form-label" for="logradouro">Logradouro:</label>
                                        			<input type="text" value="${userDto.logradouro}" name="logradouro" class="form-control " id="logradouro" readonly="readonly" >
                                        			<label class="form-label" for="cidade">Cidade:</label>
                                        			<input type="text" value="${userDto.cidade}" name="cidade" class="form-control " id="cidade" readonly="readonly" >
                                        			<label class="form-label" for="bairro">Bairro:</label>
                                        			<input type="text" value="${userDto.bairro}" name="bairro" class="form-control " id="bairro" readonly="readonly" >
                                        			<label class="form-label" for="cep">CEP:</label>
                                        			<input type="text" value="${userDto.cep}" name="cep" class="form-control " id="cep" readonly="readonly" >
                                        			<label class="form-label" for="uf">UF:</label>
                                        			<input type="text" value="${userDto.uf}" name="uf" class="form-control " id="uf" readonly="readonly" >
                                        		</div>
                                        		<div class="border border-secondary rounded shadow mt-2 p-2" id="telefones">
                                        			<h6>Selecione um usuário</h6>     			
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
	    	paginationAjax(0);	   	
	    });
    
	    function paginationAjax(pag){
	    	$.ajax({	
	    		method: "get",
	    		url: "<%= request.getContextPath() %>/ServletTelefoneController",
	    		data: "pag="+pag+"&acao=buscarComAjax",
	    		success: function (response){	    		
	
	    			var jsonResult = JSON.parse(response);
					
					$(".table > tbody > tr").remove();
					
					for(var i = 0; i < jsonResult.length; i++){

						var user = JSON.stringify(jsonResult[i]);
						var txt = '<tr>';
						txt += '<td>'+jsonResult[i].nome+'</td>';
						txt += '<td>'+jsonResult[i].user+'</td>';
						txt += '<td>';
						txt += "<i class='ti-eye' onclick='see("+jsonResult[i].id+","+user+")' style='cursor: pointer;'></i>";
						txt += '</td>';
						txt += '</tr>';
						
						$(".table > tbody").append(txt);	
					}
	    		}	        		
	    	}).fail(function(xhr, status, errorThrown){
	    		$.alert({
	    		    title: 'ERRO!',
	    		    content: 'erro ao listar usuários: '+xhr.textResponse
	    		});
	    	});
	    }
	    
	    function see(id, obj){
    		$.ajax({
    			method: "get",
    			url: "<%= request.getContextPath() %>/ServletTelefoneController",
    			data: "id="+id+"&acao=listarTelefones",
    			success: function(response){
		
    				var jsonResult = JSON.parse(response);
    				
    				if(jsonResult.length > 0 && jsonResult != null){
    					$("#telefones").html("");
    					for(var i = 0; i < jsonResult.length; i++){
        					
    						var txt = '<div class="border border-secondary rounded shadow bg-dark text-light p-2 m-2 d-inline-block">';
    						txt += '<img alt="phone-icon" src="<%= request.getContextPath() %>/img/phone-call.png" width="30px"><span class="mx-2">'+jsonResult[i].numero+'</span>';
    						txt += '<a onclick="removeTel('+jsonResult[i].id+')" alt="remover" class="text-light"><i class="ti-trash mx-2" style="cursor: pointer;"></i></a>';
    						txt += '</div>';
    						
    						$("#telefones").append(txt);		
        				}
    					
						var end = '<a href="#" onclick="cadastrarTelefone('+id+')" class="btn m-2 btn-success">Adicionar contato</a>';
						
						$("#telefones").append(end);
						
    				}else{	
    					var txt = '<div class="alert alert-secondary" role="alert">Não há telefones cadastrados</div>'
						txt += '<a role="button" onclick="cadastrarTelefone('+id+')" class="btn mx-2 btn-success">Adicionar contato</a>';

    					$("#telefones").html("");
    					$("#telefones")
    						.append(txt);
    				}  				   				
    			}
    		}).fail(function(xhr, status, errorThrown){
    			$.alert({
	    		    title: 'ERRO!',
	    		    content: 'erro ao listar telefones: '+xhr.textResponse
	    		});
    		});
    		
    		$(obj).each(function(index, element){
    			$("#nome").attr("value", element.nome);
    			$("#username").attr("value", element.user);
    			$("#email").attr("value", element.email);
    			$("#logradouro").attr("value", element.logradouro);
    			$("#cidade").attr("value", element.cidade);
    			$("#bairro").attr("value", element.bairro);
    			$("#cep").attr("value", element.cep);
    			$("#uf").attr("value", element.uf);
    		});
    	}
	    
	    function removeTel(id){
	    	$.confirm({
			    title: 'Confirmação!',
			    content: 'Deseja excluir o cadastro de telefone = '+id+'?',
			    buttons: {
			        sim: function () {
			        	$.ajax({
				    		method: "get",
			    			url: "<%= request.getContextPath() %>/ServletTelefoneController",
			    			data: "id="+id+"&acao=removerTelefone",
			    			success: function(response){
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
				    		    content: 'erro ao listar telefones: '+xhr.textResponse
				    		});
			    		});
			        },
			        não: function () {
			            $.alert('Ação cancelada!');
			        },   
			    }
			});			    	
	    }
	    
	    function cadastrarTelefone(nid){
	    	$.confirm({
	    	    title: 'Cadastrar telefone! id='+nid,
	    	    content: '' +
	    	    '<form action="" class="formName">' +
	    	    '<div class="form-group">' +
	    	    '<label>Digite o número de telefone</label>' +
	    	    '<input type="text" placeholder="Telefone" class="numero form-control" required />' +
	    	    '</div>' +
	    	    '</form>',
	    	    buttons: {
	    	        cadastrar: {
	    	            text: 'cadastrar',
	    	            btnClass: 'btn-blue',
	    	            action: function () {
	    	                var numero = this.$content.find('.numero').val();
	    	                let isnum = /^\d+$/.test(numero);
	    	                if(!numero || !isnum){
	    	                    $.alert('Digite um número valido (Apenas números permitidos)');
	    	                    return false;
	    	                }
	    	                if(numero.length > 11 || numero.length < 8){
	    	                	$.alert('Numero deve conter pelo menos 8 e no máximo 11 digitos');
	    	                    return false;
	    	                }
	    	                let uid = nid;
	    	                $.post( "<%= request.getContextPath() %>/ServletTelefoneController", { acao: "cadastraTelefone", id: uid, numero: numero } );
	    	                $.confirm({
		        			    title: 'Ação executada!',
		        			    content: 'Telefone cadastrado',
		        			    autoClose: 'ok|3000',
		        			    buttons: {
		        			        ok: function () {
		        			           see(nid, null);
		        			        }
		        			    }
		        			});
	    	            }
	    	        },
	    	        cancelar: function () {
	    	            //close
	    	        },
	    	    },
	    	    onContentReady: function () {
	    	        // bind to events
	    	        var jc = this;
	    	        this.$content.find('form').on('submit', function (e) {
	    	            // if the user submits the form by pressing enter in the field.
	    	            e.preventDefault();
	    	            jc.$$formSubmit.trigger('click'); // reference the button and click it
	    	        });
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
