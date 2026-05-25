<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Carrello" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il tuo Carrello - HairQueen Labs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-carrello">

    <header>
        <h1>HAIRQUEEN LABS</h1>
    </header>

    <div class="container-navigazione">
        <a href="home" class="btn-indietro">&larr; Continua lo shopping</a>
    </div>

    <main class="container-carrello">
        <h2>Il tuo Carrello</h2>

        <%
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            
            if (carrello == null || carrello.getElementi().isEmpty()) {
        %>
                <p class="messaggio-vuoto">Il tuo carrello è attualmente vuoto.</p>
        <%
            } else {
        %>
                <table>
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Dettagli</th>
                            <th>Prezzo Unitario</th>
                            <th>Quantità</th>
                            <th>Totale</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Carrello.ElementoCarrello elemento : carrello.getElementi()) {
                                Prodotto p = elemento.getProdotto();
                                
                                String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) ? p.getImmagineUrl() : "https://via.placeholder.com/80/1e1e1e/ffffff";
                                if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) { urlImmagine = "/" + urlImmagine; }
                        %>
                                <tr>
                                    <td><img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-carrello"></td>
                                    <td class="nome-prodotto"><%= p.getNome() %></td>
                                    <td>&euro; <%= String.format("%.2f", p.getPrezzo()) %></td>
                                    <td><%= elemento.getQuantita() %></td>
                                    <td class="totale-riga">&euro; <%= String.format("%.2f", p.getPrezzo() * elemento.getQuantita()) %></td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <div class="riepilogo-totale">
                    Totale Carrello: <span>&euro; <%= String.format("%.2f", carrello.getPrezzoTotale()) %></span>
                </div>

                <div class="azioni-carrello">
                    <form action="SvuotaCarrello" method="POST" class="form-svuota">
                        <button type="submit" class="btn btn-secondario">Svuota Carrello</button>
                    </form>
        
                    <a href="checkout" class="btn btn-primario">Procedi al Checkout</a>
                </div>
        <%
            }
        %>
    </main>

</div> </body>
</html>