<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Ordine" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // I dati passati dal Controller (ProfiloServlet)
    Utente utente = (Utente) session.getAttribute("utente");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Personale - HairQueen Labs</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="area-profilo">

    <div class="container-profilo">
        <div class="header-profilo">
            <h1>Il tuo Profilo</h1>
            <p>Benvenuta, <strong><%= utente.getNome() %> <%= utente.getCognome() %></strong></p>
            <p class="email-utente"><%= utente.getEmail() %></p>
        </div>

        <h2 class="titolo-storico">Storico Ordini</h2>

        <% if (ordini != null && !ordini.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>N° Ordine</th>
                        <th>Data</th>
                        <th>Totale</th>
                        <th>Stato</th>
                        <th></th> 
                    </tr>
                </thead>
                <tbody>
                    <% 
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                        for (Ordine o : ordini) { 
                    %>
                        <tr>
                            <td>#<%= o.getIdOrdine() %></td>
                            <td><%= (o.getDataOrdine() != null) ? sdf.format(o.getDataOrdine()) : "N/D" %></td>
                            <td class="totale-ordine"><%= String.format("%.2f", o.getTotale()) %> &euro;</td>
                            <td><span class="stato-badge"><%= o.getStato() %></span></td>
                            
                            <td class="colonna-azioni">
                                <a href="<%= request.getContextPath() %>/dettagli-ordine?id=<%= o.getIdOrdine() %>" class="btn-dettagli">
                                    Dettagli &rarr;
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="nessun-ordine">
                <h3>Nessun ordine effettuato</h3>
                <p>Non hai ancora acquistato nessun prodotto sul nostro store.</p>
            </div>
        <% } %>

        <a href="<%= request.getContextPath() %>/home" class="btn-home">&larr; Torna alla Home</a>
    </div>

</div> 
</body>
</html>