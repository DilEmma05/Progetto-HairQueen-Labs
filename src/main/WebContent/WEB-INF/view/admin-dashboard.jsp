<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Ordine" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Doppio controllo lato View (Best practice di sicurezza)
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect("login");
        return;
    }
    
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Prodotto> catalogo = (List<Prodotto>) request.getAttribute("catalogo");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Pannello Amministratore - HairQueen Labs</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Stili aggiuntivi specifici per i bottoni admin */
        .btn-modifica { background-color: #f39c12; color: #fff; padding: 5px 10px; text-decoration: none; border-radius: 3px; font-weight: bold; font-size: 0.9em; }
        .btn-modifica:hover { background-color: #d68910; }
        .btn-elimina { background-color: #e74c3c; color: #fff; border: none; padding: 6px 10px; border-radius: 3px; font-weight: bold; cursor: pointer; font-size: 0.9em; }
        .btn-elimina:hover { background-color: #c0392b; }
    </style>
</head>
<body>
<div class="area-admin">

<div class="container">
    <h1>Dashboard Amministratore</h1>
    <p>Benvenuto, Admin <%= utente.getNome() %>.</p>
    
    <% 
        String messaggioSuccesso = request.getParameter("successo");
        if ("prodottoInserito".equals(messaggioSuccesso)) { 
    %>
        <div style="background-color: #2ecc71; color: #121212; padding: 15px; border-radius: 4px; margin-bottom: 25px; font-weight: bold; text-align: center; border-left: 5px solid #27ae60;">
            &#10004; Nuovo prodotto inserito nel catalogo con successo!
        </div>
    <% } else if ("prodottoEliminato".equals(messaggioSuccesso)) { %>
        <div style="background-color: #e74c3c; color: #fff; padding: 15px; border-radius: 4px; margin-bottom: 25px; font-weight: bold; text-align: center; border-left: 5px solid #c0392b;">
            &#10004; Prodotto eliminato dal catalogo.
        </div>
    <% } else if ("prodottoModificato".equals(messaggioSuccesso)) { %>
        <div style="background-color: #f39c12; color: #fff; padding: 15px; border-radius: 4px; margin-bottom: 25px; font-weight: bold; text-align: center; border-left: 5px solid #d68910;">
            &#10004; Le modifiche al prodotto sono state salvate con successo!
        </div>
    <% } %>

    <h2 style="margin-top: 40px; color: var(--colore-accento); border-bottom: 1px solid #333; padding-bottom: 10px;">Gestione Ordini</h2>
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

    <h2 style="margin-top: 50px; color: var(--colore-accento); border-bottom: 1px solid #333; padding-bottom: 10px;">Gestione Catalogo</h2>
    
    <div style="margin: 15px 0;">
        <a href="inserisci-prodotto" style="background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; font-weight: bold; border-radius: 4px; display: inline-block;">
            <i class="fas fa-plus"></i> Aggiungi Nuovo Prodotto
        </a>
    </div>

    <% if (catalogo != null && !catalogo.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome Prodotto</th>
                    <th>Prezzo</th>
                    <th>Magazzino</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% for (Prodotto p : catalogo) { %>
                    <tr>
                        <td><%= p.getIdProdotto() %></td>
                        <td><strong><%= p.getNome() %></strong></td>
                        <td><%= String.format("%.2f", p.getPrezzo()) %> &euro;</td>
                        <td>
                            <% if (p.getQuantitaMagazzino() <= 5) { %>
                                <span style="color: #e74c3c; font-weight: bold;"><%= p.getQuantitaMagazzino() %> (In esaurimento)</span>
                            <% } else { %>
                                <%= p.getQuantitaMagazzino() %>
                            <% } %>
                        </td>
                        <td>
                            <div style="display: flex; gap: 10px; align-items: center;">
                                
                                <a href="modifica-prodotto?id=<%= p.getIdProdotto() %>" class="btn-modifica">
                                    <i class="fas fa-edit"></i> Modifica
                                </a>
                                
                                <form action="EliminaProdottoServlet" method="POST" style="margin: 0; padding: 0;" id="form-delete-<%= p.getIdProdotto() %>">
                                    <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                    <button type="button" class="btn-elimina" onclick="openDeleteModal(<%= p.getIdProdotto() %>, '<%= p.getNome().replace("'", "\\'") %>')">
                                        <i class="fas fa-trash"></i> Elimina
                                    </button>
                                </form>
                                
                            </div>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>Il catalogo è attualmente vuoto.</p>
    <% } %>

    <br><br>
    <div style="text-align: center; margin-top: 30px;">
        <a href="home" style="color: #bbb; text-decoration: none;"><i class="fas fa-arrow-left"></i> Torna al lato pubblico del sito</a>
    </div>
</div>
</div>

<div id="deleteModal" class="modal-overlay">
    <div class="modal-content">
        <div class="modal-header">
            <i class="fas fa-exclamation-circle warning-icon"></i>
            <h3>Conferma Eliminazione</h3>
        </div>
        <div class="modal-body">
            <p>Sei sicuro di voler eliminare dal catalogo:</p>
            <p><strong id="modalProductName" style="color: #fff; font-size: 1.1rem;"></strong> ?</p>
            <p class="warning-text">Questa azione è irreversibile.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-modal-annulla" onclick="closeDeleteModal()">Annulla</button>
            <button type="button" class="btn-modal-conferma" id="btnConfirmDelete">Sì, Elimina</button>
        </div>
    </div>
</div>

<script src="js/admin.js"></script>

</body>
</html>