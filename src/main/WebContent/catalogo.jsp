<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%@ page import="it.unisa.hairqueenlabs.model.Categoria" %>
<%@ page import="it.unisa.hairqueenlabs.dao.CategoriaDAO" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo Prodotti - HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-pubblica">

    <header>
        <h1>HAIRQUEEN LABS</h1>
        <p>Benvenuti nel tempio della cura dei tuoi capelli</p>
    </header>
    
    <div class="barra-utente">
        
        <a href="carrello" class="link-carrello">
            🛒 Carrello
        </a>

        <%
            Utente utente = (Utente) session.getAttribute("utente");
            if (utente == null) {
        %>
                <a href="login" class="btn-login">Accedi</a>
        <%
            } else {
        %>
                <div class="menu-utente-loggato">
                    <a href="profilo" class="link-profilo">
                        Ciao, <strong><%= utente.getNome() %></strong>
                    </a>
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
            List<Categoria> macroCategorie = (List<Categoria>) request.getAttribute("listaCategorie");
            it.unisa.hairqueenlabs.dao.CategoriaDAO catDAO = new CategoriaDAO();

            if (macroCategorie != null) {
                for (Categoria cat : macroCategorie) {
        %>
                    <li>
                        <a href="FiltroCatalogoServlet?id=<%= cat.getIdCategoria() %>">
                            <%= cat.getNomeCategoria() %> <i class="fa fa-caret-down"></i>
                        </a>

                        <div class="dropdown-content">
                            <%
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
    
    <%
        // Gestione del titolo dinamico della pagina
        String titoloPagina = (String) request.getAttribute("titoloPagina");
        if (titoloPagina == null || titoloPagina.isEmpty()) {
            titoloPagina = "La Nostra Collezione"; // Titolo di default per il catalogo completo
        }
    %>

    <!-- Banner Minimal per la pagina del catalogo -->
    <div style="background-color: #1a1a1a; border-bottom: 1px solid var(--colore-primario); padding: 40px 20px; text-align: center; margin-bottom: 30px;">
        <h2 style="color: var(--colore-accento); font-size: 2.2rem; letter-spacing: 2px; margin: 0;"><%= titoloPagina %></h2>
        <p style="color: #bbb; font-size: 1.1rem; margin-top: 10px;">L'eccellenza HairQueen Labs per la tua routine di bellezza.</p>
    </div>

    <main class="contenitore-prodotti">
        <%
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("listaProdotti");
            
            if (prodotti != null && !prodotti.isEmpty()) {
                for (Prodotto p : prodotti) {
        %>
                    <div class="card-prodotto">
            
                    <% 
                        String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                            ? p.getImmagineUrl() 
                                            : "https://via.placeholder.com/250x200/1e1e1e/ffffff?text=HairQueen+Product";
                
                        if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) {
                            urlImmagine = "/" + urlImmagine; 
                        }
                    %>
            
                    <a href="prodotto?id=<%= p.getIdProdotto() %>" style="display: block;">
                        <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-prodotto">
                    </a>
            
                    <h3>
                        <a href="prodotto?id=<%= p.getIdProdotto() %>" class="link-titolo-prodotto">
                        <%= p.getNome() %>
                        </a>
                    </h3>
                    <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                    <form action="CarrelloServlet" method="POST" style="margin-top: 15px;">
                    <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                    <button type="submit" class="btn-acquista">Aggiungi al Carrello</button>
                    </form>
                </div>
        <%
                }
            } else {
        %>
                <p style="grid-column: 1/-1; text-align: center; color: #888; padding: 40px;">
                    Nessun prodotto trovato in questa categoria.
                </p>
        <%
            }
        %>
    </main>

</div> 

</body>
</html>