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
                                        	<c:if test="${perfilUser=='admin'}">
                                        		<!-- Cards de usuários -->
                                        		<div class="col-md-6">
	                                                <div class="card">
	                                                    <div class="card-header">
	                                                        <h5>Ultimos usuários cadastrados</h5>
	                                                        <div class="card-header-right">
	                                                            <ul class="list-unstyled card-option">
	                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
	                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
	                                                                <li><i class="fa fa-minus minimize-card"></i></li>
	                                                                <li><i class="fa fa-refresh reload-card"></i></li>
	                                                                <li><i class="fa fa-trash close-card"></i></li>
	                                                            </ul>
	                                                        </div>
	                                                    </div>
	                                                    <div class="card-block">
	                                                        <c:forEach var="uc" items="${ultimosCadastrados}">
	                                                        	<div class="align-middle m-b-30">
		                                                            <img src="${uc.userImage}" alt="user image" class="img-radius img-40 align-top m-r-15">
		                                                            <div class="d-inline-block">
		                                                                <h6>${uc.nome}</h6>
		                                                                <p class="text-muted m-b-0">${uc.empresa.razaoSocial}</p>
		                                                            </div>
	                                                        	</div>
	                                                        </c:forEach>
	                                                        <div class="text-center">
	                                                            <a href="<%= request.getContextPath() %>/principal/ver-usuarios" class="b-b-primary text-primary">Ver Todos</a>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                            <div class="col-md-6">
	                                                <div class="card">
	                                                    <div class="card-header">
	                                                        <h5>Ultimas Empresas Cadastradas</h5>
	                                                        <div class="card-header-right">
	                                                            <ul class="list-unstyled card-option">
	                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
	                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
	                                                                <li><i class="fa fa-minus minimize-card"></i></li>
	                                                                <li><i class="fa fa-refresh reload-card"></i></li>
	                                                                <li><i class="fa fa-trash close-card"></i></li>
	                                                            </ul>
	                                                        </div>
	                                                    </div>
	                                                    <div class="card-block">
	                                                        <c:forEach var="uce" items="${ultimosCadastradosE}">
	                                                        	<div class="align-middle m-b-30">
		                                                            <img src="${uce.logo}" alt="user image" class="img-radius img-40 align-top m-r-15">
		                                                            <div class="d-inline-block">
		                                                                <h6>${uce.razaoSocial}</h6>
		                                                                <p class="text-muted m-b-0">${uce.representante.nome}</p>
		                                                            </div>
	                                                        	</div>
	                                                        </c:forEach>
	                                                        <div class="text-center">
	                                                            <a href="<%= request.getContextPath() %>/principal/ver-empresas" class="b-b-primary text-primary">Ver Todas</a>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
                                        	</c:if>
                                        	<c:if test="${perfilUser=='administrador'}">
                                        		<h3 id="redirect" onload="redirect()">redirecionando...</h3>
                                        	</c:if>                                        	
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
   		let perfil = '${perfilUser}';
   		if(perfil=='administrador')
   			window.location.href = '<%= request.getContextPath() %>/principal/ver-chamados/';
   	});

    </script>
</body>
</html>
