<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Ordine" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Doppio controllo lato View (Best practice di sicurezza)
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"ADMIN".equals(utente.getRuolo())) {
        response.sendRedirect("login");
        return;
    }
    
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Pannello Amministratore - HairQueen Labs</title>
    <style>
        body { background-color: #121212; color: #F5F5F5; font-family: sans-serif; padding: 20px; }
        .container { max-width: 1000px; margin: 0 auto; }
        h1 { color: #e74c3c; border-bottom: 2px solid #333; padding-bottom: 10px; } /* Rosso per distinguere l'area admin */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #1E1E1E; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #2C2C2C; }
        th { color: #e74c3c; text-transform: uppercase; }
        .btn-update { background-color: #3498db; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer; }
    </style>
</head>
<body>

<div class="container">
    <h1>Dashboard Amministratore - Gestione Ordini</h1>
    <p>Benvenuto, Admin <%= utente.getNome() %>.</p>
    
    <div style="margin: 20px 0 30px 0;">
        <a href="inserisci-prodotto" style="background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; font-weight: bold; border-radius: 4px; display: inline-block;">
            + Aggiungi Nuovo Prodotto al Catalogo
        </a>
    </div>

    <% if (ordini != null && !ordini.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>N° Ordine</th>
                    <th>ID Cliente</th>
                    <th>Data</th>
                    <th>Totale</th>
                    <th>Stato Attuale</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    for (Ordine o : ordini) { 
                %>
                    <tr>
                        <td>#<%= o.getIdOrdine() %></td>
                        <td><%= o.getIdUtente() %></td>
                        <td><%= (o.getDataOrdine() != null) ? sdf.format(o.getDataOrdine()) : "N/D" %></td>
                        <td style="font-weight: bold;"><%= String.format("%.2f", o.getTotale()) %> &euro;</td>
                        <td style="color: #f1c40f;"><%= o.getStato() %></td>
                        <td>
                            <form action="aggiorna-stato" method="post" style="display:inline;">
                                <input type="hidden" name="idOrdine" value="<%= o.getIdOrdine() %>">
                                <select name="nuovoStato" style="padding: 5px; background: #333; color: white; border: none;">
                                    <option value="In elaborazione" <%= "In elaborazione".equals(o.getStato()) ? "selected" : "" %>>In elaborazione</option>
                                    <option value="Spedito" <%= "Spedito".equals(o.getStato()) ? "selected" : "" %>>Spedito</option>
                                    <option value="Consegnato" <%= "Consegnato".equals(o.getStato()) ? "selected" : "" %>>Consegnato</option>
                                </select>
                                <button type="submit" class="btn-update">Aggiorna</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>Non ci sono ordini nel sistema.</p>
    <% } %>

    <br>
    <a href="home" style="color: #bbb;">Torna al lato pubblico del sito</a>
</div>

</body>
</html>