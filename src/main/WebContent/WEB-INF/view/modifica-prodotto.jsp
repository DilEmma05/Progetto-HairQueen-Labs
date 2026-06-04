<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect("login");
        return;
    }
    
    Prodotto p = (Prodotto) request.getAttribute("prodotto");
    if (p == null) {
        response.sendRedirect("admin-dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Prodotto - HairQueen Labs</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<div class="area-admin">
    <div class="container">
        <h1>Modifica Prodotto: <%= p.getNome() %></h1>
        <p>Aggiorna i dettagli del prodotto e clicca su Salva.</p>
        
        <div class="form-container">
            <form action="modifica-prodotto" method="POST">
                <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                
                <div class="form-group">
                    <label>Nome Prodotto *</label>
                    <input type="text" name="nome" value="<%= p.getNome() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Descrizione *</label>
                    <textarea name="descrizione" required><%= p.getDescrizione() %></textarea>
                </div>
                
                <div style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Prezzo (&euro;) *</label>
                        <input type="number" step="0.01" name="prezzo" value="<%= p.getPrezzo() %>" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Quantità Magazzino *</label>
                        <input type="number" name="quantitaMagazzino" value="<%= p.getQuantitaMagazzino() %>" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>URL Immagine (es. /img/prodotti/shampoo.png)</label>
                    <input type="text" name="immagineUrl" value="<%= (p.getImmagineUrl() != null) ? p.getImmagineUrl() : "" %>">
                </div>
                
                <div style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Fase di Utilizzo (es. Detersione, Styling)</label>
                        <input type="text" name="faseUtilizzo" value="<%= (p.getFaseUtilizzo() != null) ? p.getFaseUtilizzo() : "" %>">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>ID Sottocategoria (es. 1 per Shampoo, 2 per Balsamo)</label>
                        <input type="number" name="idSottocategoria" value="<%= p.getIdSottocategoria() %>">
                    </div>
                </div>
                
                <div style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Target Cute (es. Grassa, Secca, Tutti)</label>
                        <input type="text" name="tipoCuteTarget" value="<%= (p.getTipoCuteTarget() != null) ? p.getTipoCuteTarget() : "" %>">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Target Capello (es. Lisci, Ricci, Tutti)</label>
                        <input type="text" name="tipoCapelloTarget" value="<%= (p.getTipoCapelloTarget() != null) ? p.getTipoCapelloTarget() : "" %>">
                    </div>
                </div>
                
                <div class="form-group" style="display: flex; align-items: center; gap: 10px; margin-top: 10px;">
                    <input type="checkbox" name="isNovita" value="true" id="checkNovita" <%= p.isNovita() ? "checked" : "" %> style="width: auto;">
                    <label for="checkNovita" style="margin-bottom: 0; display: inline; color: #fff; font-weight: normal;">Contrassegna come Novità (Mostra nell'Homepage)</label>
                </div>
                
                <div style="margin-top: 30px; display: flex; justify-content: space-between; align-items: center;">
                    <a href="admin-dashboard" style="color: #bbb; text-decoration: none;">Annulla e Torna Indietro</a>
                    <button type="submit" class="btn-salva">Salva Modifiche</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>