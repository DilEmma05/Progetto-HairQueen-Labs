<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Categoria" %>
<%@ page import="it.unisa.hairqueenlabs.dao.CategoriaDAO" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>

<header>
    <h1>HAIRQUEEN LABS</h1>
    <p>Benvenuti nel tempio della cura dei tuoi capelli</p>
</header>

<div class="barra-utente">
        
        <a href="<%= request.getContextPath() %>/carrello" class="link-carrello">
            🛒 Carrello 
            <span id="cart-badge" class="cart-badge">
                <% 
                   it.unisa.hairqueenlabs.model.Carrello c = (it.unisa.hairqueenlabs.model.Carrello) session.getAttribute("carrello");
                   out.print((c != null) ? c.getNumeroTotaleArticoli() : "0");
                %>
            </span>
        </a>

        <%
            Utente utente = (Utente) session.getAttribute("utente");
            if (utente == null) {
        %>
                <a href="<%= request.getContextPath() %>/login" class="btn-login">Accedi</a>
        <%
            } else {
        %>
                <div class="menu-utente-loggato">
                    <a href="<%= request.getContextPath() %>/profilo" class="link-profilo">
                        Ciao, <strong><%= utente.getNome() %></strong>
                    </a>
                    
                    <% if ("admin".equalsIgnoreCase(utente.getRuolo())) { %>
                        <a href="<%= request.getContextPath() %>/admin-dashboard" class="btn-admin">Pannello Admin</a>
                    <% } %>
                    
                    <a href="<%= request.getContextPath() %>/logout" class="btn-logout">Esci</a>
                </div>
        <%
            }
        %>
    </div>

<nav>
    <ul>
    <li><a href="<%= request.getContextPath() %>/home#ultimi-arrivi">Novità</a></li>
    <li><a href="<%= request.getContextPath() %>/catalogo">Tutti i Prodotti</a></li>
    
    <%
        it.unisa.hairqueenlabs.dao.CategoriaDAO catDAO = new it.unisa.hairqueenlabs.dao.CategoriaDAO();
        List<Categoria> macroCategorie = (List<Categoria>) request.getAttribute("listaCategorie");
        
        if (macroCategorie == null) {
            try {
                macroCategorie = catDAO.doRetrieveAllCategorie();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (macroCategorie != null) {
            for (Categoria cat : macroCategorie) {
    %>
                <li>
                    <a href="<%= request.getContextPath() %>/FiltroCatalogoServlet?id=<%= cat.getIdCategoria() %>">
                        <%= cat.getNomeCategoria() %> <i class="fa fa-caret-down"></i>
                    </a>

                    <div class="dropdown-content">
                        <%
                            try {
                                List<it.unisa.hairqueenlabs.model.Sottocategoria> sottoCats = 
                                    catDAO.doRetrieveSottocategorie(cat.getIdCategoria());
                                
                                if (sottoCats != null) {
                                    for (it.unisa.hairqueenlabs.model.Sottocategoria s : sottoCats) {
                        %>
                                        <a href="<%= request.getContextPath() %>/FiltroSottocategoriaServlet?id=<%= s.getIdSottocategoria() %>">
                                            <%= s.getNomeSottocategoria() %>
                                        </a>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </li>
    <%
            }
        }
    %>
    <li><a href="<%= request.getContextPath() %>/routine">Trova Routine ✨</a></li>
</ul>
</nav>