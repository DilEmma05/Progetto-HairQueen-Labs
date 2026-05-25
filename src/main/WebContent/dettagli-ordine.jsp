<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.DettaglioOrdine" %>

<%
    List<DettaglioOrdine> dettagli = (List<DettaglioOrdine>) request.getAttribute("dettagli");
    Integer idOrdine = (Integer) request.getAttribute("idOrdine");
    
    if (dettagli == null) { response.sendRedirect("profilo"); return; }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dettagli Ordine #<%= idOrdine %> - HairQueen Labs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-dettaglio-ordine">
    <div class="container-dettaglio-ordine">
        <h1>Dettagli Ordine #<%= idOrdine %></h1>

        <table>
            <thead>
                <tr>
                    <th>Prodotto</th>
                    <th>Quantità</th>
                    <th>Prezzo Unit.</th>
                    <th>Subtotale</th>
                </tr>
            </thead>
            <tbody>
                <% for (DettaglioOrdine d : dettagli) { %>
                    <tr>
                        <td><%= d.getNomeProdotto() %></td>
                        <td><%= d.getQuantitaAcquistata() %></td>
                        <td><%= String.format("%.2f", d.getPrezzoUnitario()) %> &euro;</td>
                        <td class="subtotale-riga">
                            <%= String.format("%.2f", d.getPrezzoUnitario() * d.getQuantitaAcquistata()) %> &euro;
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="azioni-dettaglio">
            <a href="profilo" class="btn-back">&larr; Torna allo Storico Ordini</a>
            
            <a href="scarica-fattura?id=<%= idOrdine %>" class="btn-fattura">
                📄 Scarica Fattura (PDF)
            </a>
        </div>
    </div>
</div>

</body>
</html>