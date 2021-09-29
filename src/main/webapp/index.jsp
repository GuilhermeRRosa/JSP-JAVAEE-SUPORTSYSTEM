<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    
    <link href="<%= request.getContextPath() %>/css/login.css" type="text/css" rel="stylesheet">

<title>Project Jsp</title>
</head>
<body>
	<div class="d-flex justify-content-center d-column align-items-center vh-100 container-login">
		<div class="box-login p-3 border rounded-1 shadow">
			<c:if test = "${msg != null}">
				<div class="alert alert-warning text-center" role="alert">
					<span>
						${msg}
					</span>
				</div>
			</c:if>
			<h4 class="text-center">Projeto JSP - Bem-vindo(a)</h4>
			<form action="<%= request.getContextPath() %>/ServletLogin" method="post" class="m-3 needs-validation" novalidate>
				<!-- Input que contém o Url da pagina que tentou ser acessada, veja no filter de autenticação -->
				<input type="hidden" value="${url}" name="url">
				<div class="mb-2">
					<label for="nome" class="form-label">User:</label>
					<input type="text" name="user" class="form-control" required/>
					<div class="valid-feedback">
						Ok
					</div>
					<div class="invalid-feedback">
						Digite o nome de usuário.
					</div>
				</div>
				<div class="mb-2">
					<label for="idade" class="form-label">Password:</label>
					<input type="password" name="password" class="form-control" required/>
					<div class="valid-feedback">
						Ok
					</div>
					<div class="invalid-feedback">
						Senha não pode ser em branco.
					</div>
				</div>
				<div class="d-flex justify-content-end">
					<button type="submit" class="btn btn-secondary align-self-end">Enviar</button>
				</div>	
			</form>
		</div>
	</div>
 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
 <script type="text/javascript">
//Example starter JavaScript for disabling form submissions if there are invalid fields
 (function () {
   'use strict'

   // Fetch all the forms we want to apply custom Bootstrap validation styles to
   var forms = document.querySelectorAll('.needs-validation')

   // Loop over them and prevent submission
   Array.prototype.slice.call(forms)
     .forEach(function (form) {
       form.addEventListener('submit', function (event) {
         if (!form.checkValidity()) {
           event.preventDefault()
           event.stopPropagation()
         }

         form.classList.add('was-validated')
       }, false)
     })
 })()
 </script>
</body>
</html>