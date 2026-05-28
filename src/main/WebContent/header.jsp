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
    <a href="carrello" class="link-carrello">🛒 Carrello</a>

    <%
        Utente utente = (Utente) session.getAttribute("utente");
        if (utente == null) {
    %>
            <a href="login" class="btn-login">Accedi</a>
    <%
        } else {
    %>
            <div class="menu-utente-loggato">
                <a href="profilo" class="link-profilo">Ciao, <strong><%= utente.getNome() %></strong></a>
                <a href="logout" class="btn-logout">Esci</a>
            </div>
    <%
        }
    %>
</div>

<nav>
    <ul>
    <li><a href="home#ultimi-arrivi">Novità</a></li>
    <li><a href="catalogo">Tutti i Prodotti</a></li>
    
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
                    <a href="FiltroCatalogoServlet?id=<%= cat.getIdCategoria() %>">
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
                                        <a href="FiltroSottocategoriaServlet?id=<%= s.getIdSottocategoria() %>">
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
    <li><a href="routine">Trova Routine ✨</a></li>
</ul>
</nav>