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
                                    		<div class="col-md-12">
                                        		<div class="card">
                                        			<div class="card-body">
                                        				<h3>Gráfico de chamados</h3>
                                        			</div>
                                        		</div>
                                        		<div class="card">
                                        			<div class="card-body">
                                        				<form action="<%= request.getContextPath() %>/ServletRelatorioController" method="get" id="form-rel">
                                        					<input type="hidden" name="acao" value="geraRelatorio">
                                        					<div class="row">
                                        						<div class="col-md-6">
	                                        						<label for="criadoEm">Data inicial</label>
	                                        						<input type="date" name="de" class="de form-control"/>	
	                                        					</div>
	                                        					<div class="col-md-6">
	                                        						<label for="criadoEm">Data de conclusão</label>
	                                        						<input type="date" name="para" class="para form-control"/>
	                                        					</div>     
                                        					</div>
                                        					<div class="row my-3">
                                        						<div class="col-md-12">
                                        							<button onclick="gerarRelatorio()" class="float-right btn btn-primary">Gerar</button>
                                        						</div>
                                        					</div>
                                        				</form>
                                        			</div>
                                        		</div>
                                        	</div> 
                                    	</div>
                                        <div class="row">
                                        	<div class="col-md-12">
                                        	<div class="card">
                                        			<div class="card-body">
                                        				<canvas id="myChart"></canvas>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    <script type="text/javascript"> 
	   	    
	    function gerarRelatorio(){
	    	$("#form-rel").submit(function(){
	    		return false;
	    	});
	    	
	    	var action = $("#form-rel").attr('action');
	    	var de = $(".de").val();
	    	var para = $(".para").val();
	    	
	    	$.ajax({
	    		method: 'get',
	    		url: action,
	    		data: "acao=gerarRelatorio&de="+de+"&para="+para,
	    		success: function (response){
	    			
	    			console.log(response);
	    			
	    				var jsonResult = JSON.parse(response);
	    			
	    				const ctx = document.getElementById('myChart').getContext('2d');
	    			    const myChart = new Chart(ctx, {
	    			        type: 'bar',
	    			        data: {
	    			            /* labels: ['Chamados','Pendencia', 'Abertos', 'Em atendimento', 'concluídos'], */
	    			            datasets: [{
	    			                label: 'qtd. de atendimentos',
	    			                data: jsonResult,
	    			                backgroundColor: [
	    			                    'rgba(255, 99, 132, 0.2)',
	    			                    'rgba(54, 162, 235, 0.2)',
	    			                    'rgba(255, 206, 86, 0.2)',
	    			                    'rgba(75, 192, 192, 0.2)'	    			                    
	    			                ],
	    			                borderColor: [
	    			                    'rgba(255, 99, 132, 1)',
	    			                    'rgba(54, 162, 235, 1)',
	    			                    'rgba(255, 206, 86, 1)',
	    			                    'rgba(75, 192, 192, 1)'
	    			                ],
	    			                borderWidth: 1
	    			            }]
	    			        },
	    			        options: {
	    			            scales: {
	    			                y: {
	    			                    beginAtZero: true
	    			                }
	    			            }
	    			        }
	    			    });
	    		}
	    	}).fail(function(xhr, status, errorThrown){
        		$.alert({
        		    title: 'ERRO!',
        		    content: 'erro ao buscar por nome: '+xhr.textResponse
        		});
        	}); 
	    }
	    
    </script>
</body>
</html>
