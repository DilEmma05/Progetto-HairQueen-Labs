<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Ordine" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Recuperiamo utente e ordini
    Utente utente = (Utente) session.getAttribute("utente");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    
    // Sicurezza extra: se si accede alla pagina senza passare dalla Servlet
    if (utente == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Personale - HairQueen Labs</title>
    <style>
        :root {
            --sfondo-principale: #121212;
            --testo-principale: #F5F5F5;
            --colore-primario: #8E44AD; 
            --colore-accento: #D4AF37;   
            --sfondo-card: #1E1E1E;
        }
        body {
            background-color: var(--sfondo-principale);
            color: var(--testo-principale);
            font-family: 'Segoe UI', sans-serif;
            margin: 0; padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        .header-profilo {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #2C2C2C;
            margin-bottom: 30px;
        }
        .header-profilo h1 { color: var(--colore-accento); }
        
        /* Stile per la tabella degli ordini */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--sfondo-card);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #2C2C2C;
        }
        th {
            background-color: #1a1a1a;
            color: var(--colore-primario);
            font-weight: bold;
            text-transform: uppercase;
        }
        tr:hover { background-color: #252525; }
        .stato-badge {
            background-color: rgba(46, 204, 113, 0.1);
            color: #2ecc71;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: bold;
        }
        .btn-home {
            display: inline-block;
            margin-top: 20px;
            color: var(--colore-primario);
            text-decoration: none;
            font-weight: bold;
        }
        .nessun-ordine {
            text-align: center;
            padding: 40px;
            color: #bbb;
            background-color: var(--sfondo-card);
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-profilo">
        <h1>Il tuo Profilo</h1>
        <p>Benvenuta, <strong><%= utente.getNome() %> <%= utente.getCognome() %></strong></p>
        <p style="color: #888; font-size: 0.9rem;"><%= utente.getEmail() %></p>
    </div>

    <h2 style="color: var(--colore-accento); margin-bottom: 15px;">Storico Ordini</h2>

    <% if (ordini != null && !ordini.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>N° Ordine</th>
                    <th>Data</th>
                    <th>Totale</th>
                    <th>Stato</th>
                    <th></th> </tr>
            </thead>
            <tbody>
                <% 
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    for (Ordine o : ordini) { 
                %>
                    <tr>
                        <td>#<%= o.getIdOrdine() %></td>
                        <td><%= (o.getDataOrdine() != null) ? sdf.format(o.getDataOrdine()) : "N/D" %></td>
                        <td style="font-weight: bold;"><%= String.format("%.2f", o.getTotale()) %> &euro;</td>
                        <td><span class="stato-badge"><%= o.getStato() %></span></td>
                        
                        <td style="text-align: right;">
                            <a href="dettagli-ordine?id=<%= o.getIdOrdine() %>" style="color: var(--colore-accento); text-decoration: none; font-size: 0.9rem; border: 1px solid var(--colore-accento); padding: 5px 10px; border-radius: 4px; transition: 0.3s;" onmouseover="this.style.backgroundColor='var(--colore-accento)'; this.style.color='#121212';" onmouseout="this.style.backgroundColor='transparent'; this.style.color='var(--colore-accento)';">
                                Dettagli &rarr;
                            </a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <div class="nessun-ordine">
            <h3 style="margin:0 0 10px 0;">Nessun ordine effettuato</h3>
            <p>Non hai ancora acquistato nessun prodotto sul nostro store.</p>
        </div>
    <% } %>

    <a href="home" class="btn-home">&larr; Torna alla Home</a>
</div>

</body>
</html>