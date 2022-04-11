<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<nav class="pcoded-navbar">
                      <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
                      <div class="pcoded-inner-navbar main-menu">
                          <div class="">
                              <div class="main-menu-header">
                              	<div class="box-img-custom-user">
                                  <img class="img-80 img-radius" src="${userImg}" alt="User-Profile-Image">                              	
                              	</div>
                                  <div class="user-details">
                                      <span id="more-details">${usuario}<i class="fa fa-caret-down"></i></span>
                                  </div>
                              </div>
        
                              <div class="main-menu-content">
                                  <ul>
                                      <li class="more-details">                                          
                                          <a href="<%= request.getContextPath() %>/ServletLogin?acao=logout"><i class="ti-layout-sidebar-left"></i>Sair</a>
                                      </li>
                                  </ul>
                              </div>
                          </div>                         
                          <div class="pcoded-navigation-label" data-i18n="nav.category.navigation">Dados</div>
                          <ul class="pcoded-item pcoded-left-item">
                              <li class="active">
                                  <a href="<%= request.getContextPath() %>/principal/inicio" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.dash.main">Dashboard</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                              <c:if test="${perfilUser=='admin' || perfilUser=='administrador' || perfilUser=='colaborador'}"> 
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-user"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Usuários</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                  	<c:if test="${perfilUser=='admin' || perfilUser=='administrador'}">
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/cadastrar-usuario.jsp" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Cadastrar Usuário</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                    </c:if>
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/ver-usuarios" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Ver todos</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>             
                                  </ul>                                 
                              </li>                             
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-user"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Empresas</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                  	<c:if test="${perfilUser=='admin' || perfilUser=='administrador'}">
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/cadastrar-empresa.jsp" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Cadastrar Empresa</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                    </c:if>
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/ver-empresas" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Ver todos</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>             
                                  </ul>                                 
                              </li>
                              </c:if>
                              <li>
                                  <a href="<%= request.getContextPath() %>/principal/ver-contatos" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-mobile"></i><b>D</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.dash.main">Contatos</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                          </ul>
                          <c:if test="${!admin}">
                          <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Atendimento</div>
                          <ul class="pcoded-item pcoded-left-item">
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-user"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Chamados</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                  	<c:if test="${perfilUser=='administrador' || perfilUser=='colaborador'}">
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/ver-chamados/" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Ver chamados</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/ver-concluidos" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Concluídos</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>              
                                    </c:if>
                                    
                                    <!-- MENU CLIENTE -->
                                    <c:if test="${perfilUser=='cliente'}">
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/abrir-chamado/" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Abrir chamado</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                   	  <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/ver-chamados/" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Meus chamados</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/principal/ver-concluidos" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Concluídos</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>  
                                    </c:if>
                                  </ul> 
                              </li>
        					</ul>
        					</c:if>
        				  <c:if test="${perfilUser=='administrador'}">
        				  	<div class="pcoded-navigation-label" data-i18n="nav.category.other">Relatórios</div>
	                          <ul class="pcoded-item pcoded-left-item">
	                              <li class="pcoded-hasmenu ">
	                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
	                                      <span class="pcoded-micon"><i class="ti-direction-alt"></i><b>M</b></span>
	                                      <span class="pcoded-mtext" data-i18n="nav.menu-levels.main">Categorias</span>
	                                      <span class="pcoded-mcaret"></span>
	                                  </a>
	                                  <ul class="pcoded-submenu">
	                                      <li>
	                                          <a href="<%= request.getContextPath() %>/principal/ver-relatorios/clientes/" class="waves-effect waves-dark">
	                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-21">Clientes</span>
	                                              <span class="pcoded-mcaret"></span>
	                                          </a>
	                                      </li>
	                                      <li>
	                                          <a href="<%= request.getContextPath() %>/principal/ver-relatorios/chamados/" class="waves-effect waves-dark">
	                                              <span class="pcoded-micon"><i class="ti-direction-alt"></i></span>
	                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.main">Chamados</span>
	                                              <span class="pcoded-mcaret"></span>
	                                          </a>
	                                      </li>
	                                      <li>
	                                          <a href="javascript:void(0)" class="waves-effect waves-dark">
	                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-23">Empresas</span>
	                                              <span class="pcoded-mcaret"></span>
	                                          </a>
	                                      </li>
	                                      <li class="">
	                                          <a href="javascript:void(0)" class="waves-effect waves-dark">
	                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-23">Funcionários</span>
	                                              <span class="pcoded-mcaret"></span>
	                                          </a>
	                                      </li>
	                                  </ul>
	                              </li>
	                          </ul>
        				  </c:if>
                          
                      </div>
                  </nav>