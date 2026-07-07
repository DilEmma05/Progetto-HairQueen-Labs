<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    String queryRicerca = (String) request.getAttribute("queryRicerca");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Risultati ricerca per "<%= queryRicerca %>" - HairQueen Labs</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="area-pubblica">
    <jsp:include page="header.jsp" />

    <div class="banner-catalogo">
        <h2 class="banner-titolo">Risultati Ricerca</h2>
        <% if (queryRicerca != null && !queryRicerca.trim().isEmpty()) { %>
            <p class="banner-sottotitolo">Hai cercato: "<strong><%= queryRicerca %></strong>"</p>
        <% } %>
    </div>

    <main class="contenitore-prodotti">
        <% if (prodotti != null && !prodotti.isEmpty()) { 
            for (Prodotto p : prodotti) { 
                String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                     ? p.getImmagineUrl() 
                                     : "https://via.placeholder.com/250x250/1e1e1e/ffffff?text=Prodotto";
                if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) urlImmagine = "/" + urlImmagine;
        %>
            <article class="card-prodotto">
                <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-immagine-prodotto">
                    <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-prodotto">
                </a>
                <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-titolo-prodotto">
                    <h3><%= p.getNome() %></h3>
                </a>
                <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                
                <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-ajax-carrello">
                    <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                    <button type="submit" class="btn-acquista">Aggiungi</button>
                </form>
            </article>
        <%  } 
        } else { %>
            <div class="messaggio-catalogo-vuoto" style="grid-column: 1 / -1; text-align: center; margin: 50px 0;">
                <i class="fas fa-search" style="font-size: 3rem; color: #555; margin-bottom: 20px;"></i>
                <h3>Nessun prodotto trovato.</h3>
                <p>Prova a cercare usando termini diversi o torna al <a href="<%= request.getContextPath() %>/home" style="color: var(--colore-accento);">Catalogo Completo</a>.</p>
            </div>
        <% } %>
    </main>
</div>
<script src="<%= request.getContextPath() %>/scripts/ajax-carrello.js"></script>
</body>
</html>