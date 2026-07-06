<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Ordine" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Dati passati dal Controller (AdminDashboardServlet)
    Utente utente = (Utente) session.getAttribute("utente");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Prodotto> catalogo = (List<Prodotto>) request.getAttribute("catalogo");
    
    // Recupero i parametri per capire cosa stiamo visualizzando
    String scopeVisualizzazione = (String) request.getAttribute("scopeVisualizzazione");
    String scopeOrdini = (String) request.getAttribute("scopeOrdini");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Pannello Amministratore - HairQueen Labs</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        <div class="alert alert-success">
            &#10004; Nuovo prodotto inserito nel catalogo con successo!
        </div>
    <% } else if ("prodottoEliminato".equals(messaggioSuccesso)) { %>
        <div class="alert alert-danger">
            &#10004; Prodotto eliminato dal catalogo.
        </div>
    <% } else if ("prodottoModificato".equals(messaggioSuccesso)) { %>
        <div class="alert alert-warning">
            &#10004; Le modifiche al prodotto sono state salvate con successo!
        </div>
    <% } %>

    <h2 class="admin-section-title">
        <%= "tutti".equals(scopeOrdini) ? "Gestione Ordini - Tutti gli Ordini dei Clienti" : "Gestione Ordini - I Miei Ordini Effettuati" %>
    </h2>

    <div class="margin-y-15" style="margin-bottom: 20px;">
        <% if ("tutti".equals(scopeOrdini)) { %>
            <a href="<%= request.getContextPath() %>/admin-dashboard" class="btn-update" style="text-decoration: none; padding: 10px 15px; display: inline-block; background-color: #28a745; border-radius: 4px; color: white;">
                <i class="fas fa-shopping-bag"></i> Mostra Solo i Miei Ordini
            </a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/admin-dashboard?mostraOrdini=tutti" class="btn-update" style="text-decoration: none; padding: 10px 15px; display: inline-block; background-color: #6c757d; border-radius: 4px; color: white;">
                <i class="fas fa-globe"></i> Gestisci Ordini Globale (Tutti i Clienti)
            </a>
        <% } %>
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
                        <td class="testo-totale-ordine"><%= String.format("%.2f", o.getTotale()) %> &euro;</td>
                        <td class="testo-stato-ordine"><%= o.getStato() %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/aggiorna-stato" method="post" class="form-inline">
                                <input type="hidden" name="idOrdine" value="<%= o.getIdOrdine() %>">
                                <select name="nuovoStato" class="select-stato">
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
        <p>Non ci sono ordini in questa visualizzazione.</p>
    <% } %>

    <h2 class="admin-section-title">
        <%= "tutti".equals(scopeVisualizzazione) ? "Gestione Catalogo - Tutti i Prodotti del Sistema" : "Gestione Catalogo - I Miei Prodotti" %>
    </h2>
    
    <div class="margin-y-15" style="margin-bottom: 20px;">
        <a href="<%= request.getContextPath() %>/inserisci-prodotto" class="btn-nuovo-prodotto" style="display: inline-block; margin-right: 15px;">
            <i class="fas fa-plus"></i> Aggiungi Nuovo Prodotto
        </a>
        
        <% if ("tutti".equals(scopeVisualizzazione)) { %>
            <a href="<%= request.getContextPath() %>/admin-dashboard" class="btn-update" style="text-decoration: none; padding: 10px 15px; display: inline-block; background-color: #28a745; border-radius: 4px; color: white;">
                <i class="fas fa-user"></i> Mostra Solo i Miei Prodotti
            </a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/admin-dashboard?mostra=tutti" class="btn-update" style="text-decoration: none; padding: 10px 15px; display: inline-block; background-color: #6c757d; border-radius: 4px; color: white;">
                <i class="fas fa-users"></i> Vedi Prodotti di Tutti gli Utenti
            </a>
        <% } %>
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
                                <span class="testo-esaurimento"><%= p.getQuantitaMagazzino() %> (In esaurimento)</span>
                            <% } else { %>
                                <%= p.getQuantitaMagazzino() %>
                            <% } %>
                        </td>
                        <td>
                            <div class="container-azioni-tabella">
                                
                                <a href="<%= request.getContextPath() %>/modifica-prodotto?id=<%= p.getIdProdotto() %>" class="btn-modifica">
                                    <i class="fas fa-edit"></i> Modifica
                                </a>
                                
                                <form action="<%= request.getContextPath() %>/EliminaProdottoServlet" method="POST" class="form-inline" id="form-delete-<%= p.getIdProdotto() %>">
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
    <div class="container-torna-home">
        <a href="<%= request.getContextPath() %>/home" class="link-back"><i class="fas fa-arrow-left"></i> Torna al lato pubblico del sito</a>
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
            <p><strong id="modalProductName" class="modal-product-name"></strong> ?</p>
            <p class="warning-text">Questa azione è irreversibile.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-modal-annulla" onclick="closeDeleteModal()">Annulla</button>
            <button type="button" class="btn-modal-conferma" id="btnConfirmDelete">Sì, Elimina</button>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/scripts/admin.js"></script>

</body>
</html>