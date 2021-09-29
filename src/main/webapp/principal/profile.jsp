<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
                                        	<div class="col-md-6 shadow">
                                        		<div class="card">
                                        			<div class="card-header">
                                                        <h5>Meu Perfil</h5>
                                                    </div>
                                        			<div class="card-block">
                                        				<form action="<%= request.getContextPath() %>/ServletUserController" method="post" class="form-material">
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="id" id="id" class="form-control" value="${userDto.id}" placeholder="Aqui vai o id" required="required" disabled>
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Id</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="nome" id="nome" class="form-control" value="${userDto.nome}" placeholder="Digite o seu nome" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Nome completo</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="email" name="email" id="email" class="form-control" value="${userDto.email}" placeholder="Digite o seu e-mail" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">email</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="text" name="username" id="username" class="form-control" value="${userDto.user}" placeholder="Digite o seu nick" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Nickname</label>
                                        					</div>
                                        					<div class="form-group form-default form-static-label">
                                        						<input type="password" name="password" id="password" class="form-control" required="required">
                                        						<span class="form-bar"></span>
                                        						<label class="float-label">Senha</label>
                                        					</div>
                                        					<div class="d-flex flex-row-reverse">
                                        						<button type="submit" class="btn btn-primary waves-effect waves-light">Salvar</button>
                                        					</div>
                                        				</form>
                                        			</div>
                                        		</div>
                                        	
                                        	</div>
                                        	<!-- form Container -->         
                                        	
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
</body>
</html>
