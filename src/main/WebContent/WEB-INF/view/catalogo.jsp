<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo Prodotti - HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-pubblica">

    <jsp:include page="header.jsp"/>
    
    <%
        // Gestione del titolo dinamico della pagina
        String titoloPagina = (String) request.getAttribute("titoloPagina");
        if (titoloPagina == null || titoloPagina.isEmpty()) {
            titoloPagina = "La Nostra Collezione"; // Titolo di default per il catalogo completo
        }
    %>

    <div class="banner-catalogo">
        <h2 class="banner-titolo"><%= titoloPagina %></h2>
        <p class="banner-sottotitolo">L'eccellenza HairQueen Labs per la tua routine di bellezza.</p>
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
            
                    <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-immagine-prodotto">
                        <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-prodotto">
                    </a>
            
                    <h3>
                        <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-titolo-prodotto">
                        <%= p.getNome() %>
                        </a>
                    </h3>
                    <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                    
                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-ajax-carrello">
                        <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                        <button type="submit" class="btn-acquista">Aggiungi al Carrello</button>
                    </form>
                </div>
        <%
                }
            } else {
        %>
                <p class="messaggio-catalogo-vuoto">
                    Nessun prodotto trovato in questa categoria.
                </p>
        <%
            }
        %>
    </main>
    
    <jsp:include page="footer.jsp" />

</div> 

<script src="<%= request.getContextPath() %>/scripts/ajax-carrello.js"></script>

</body>
</html>