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
    <style>
        body { background-color: #121212; color: #F5F5F5; font-family: sans-serif; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background-color: #1E1E1E; padding: 30px; border-radius: 8px; }
        h1 { color: #D4AF37; text-align: center; border-bottom: 1px solid #2C2C2C; padding-bottom: 20px;}
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #2C2C2C; }
        th { color: #8E44AD; text-transform: uppercase; }
        .btn-back { display: inline-block; margin-top: 30px; color: #8E44AD; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
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
                    <td style="font-weight: bold; color: #D4AF37;">
                        <%= String.format("%.2f", d.getPrezzoUnitario() * d.getQuantitaAcquistata()) %> &euro;
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
    
    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 30px;">
        <a href="profilo" class="btn-back">&larr; Torna allo Storico Ordini</a>
        
        <a href="scarica-fattura?id=<%= idOrdine %>" style="background-color: var(--colore-accento); color: var(--sfondo-principale); padding: 10px 20px; text-decoration: none; font-weight: bold; border-radius: 4px; transition: 0.3s; display: inline-block;">
            📄 Scarica Fattura (PDF)
        </a>
    </div>

    <a href="profilo" class="btn-back">&larr; Torna allo Storico Ordini</a>
</div>

</body>
</html>