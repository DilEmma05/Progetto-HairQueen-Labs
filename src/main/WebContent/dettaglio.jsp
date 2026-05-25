<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettaglio Prodotto - HairQueen Labs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-dettaglio">

    <header>
        <h1>HAIRQUEEN LABS</h1>
    </header>

    <div class="container-navigazione">
        <a href="home" class="btn-indietro">&larr; Torna al Catalogo</a>
    </div>

    <%
        Prodotto p = (Prodotto) request.getAttribute("prodotto");
        
        if (p != null) {
            String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                 ? p.getImmagineUrl() 
                                 : "https://via.placeholder.com/450x500/1e1e1e/ffffff?text=HairQueen+Product";
            
            if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) {
                urlImmagine = "/" + urlImmagine; 
            }
    %>
            <main class="container-dettaglio">
                <div class="colonna-sinistra">
                    <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>">
                </div>
                
                <div class="colonna-destra">
                    <h2><%= p.getNome() %></h2>
                    <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                    
                    <p class="descrizione">
                        <%= p.getDescrizione() != null && !p.getDescrizione().isEmpty() 
                            ? p.getDescrizione() 
                            : "Vizia i tuoi capelli con questo esclusivo trattamento HairQueen Labs. La descrizione dettagliata per questo prodotto di lusso sarà disponibile a breve." %>
                    </p>
                    
                    <form action="CarrelloServlet" method="POST">
                        <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                        <button type="submit" class="btn-aggiungi">Aggiungi al Carrello</button>
                    </form>
                </div>
            </main>
    <%
        } else {
    %>
            <div class="prodotto-non-trovato">
                <h2>Errore!</h2>
                <p>Il prodotto che stai cercando non esiste o è stato rimosso.</p>
            </div>
    <%
        }
    %>

</div> </body>
</html>