<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>

<%
    // Recupero il prodotto passato dal Controller (nessuna logica di redirect qui)
    Prodotto p = (Prodotto) request.getAttribute("prodotto");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Prodotto - HairQueen Labs</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-admin">
    <div class="container">
        <h1>Modifica Prodotto: <%= p.getNome() %></h1>
        <p>Aggiorna i dettagli del prodotto e clicca su Salva.</p>
        
        <div class="form-container">
            <form action="<%= request.getContextPath() %>/modifica-prodotto" method="POST">
                <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                
                <div class="form-group">
                    <label>Nome Prodotto *</label>
                    <input type="text" name="nome" value="<%= p.getNome() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Descrizione</label>
                    <textarea name="descrizione"><%= (p.getDescrizione() != null) ? p.getDescrizione() : "" %></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group flex-1">
                        <label>Prezzo (&euro;) *</label>
                        <input type="number" step="0.01" name="prezzo" value="<%= p.getPrezzo() %>" required>
                    </div>
                    <div class="form-group flex-1">
                        <label>Quantità Magazzino *</label>
                        <input type="number" name="quantitaMagazzino" value="<%= p.getQuantitaMagazzino() %>" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>URL Immagine (es. /images/prodotti/shampoo.png)</label>
                    <input type="text" name="immagineUrl" value="<%= (p.getImmagineUrl() != null) ? p.getImmagineUrl() : "" %>">
                </div>
                
                <div class="form-row">
                    <div class="form-group flex-1">
                        <label>Fase di Utilizzo (es. Detersione, Styling)</label>
                        <input type="text" name="faseUtilizzo" value="<%= (p.getFaseUtilizzo() != null) ? p.getFaseUtilizzo() : "" %>">
                    </div>
                    <div class="form-group flex-1">
                        <label>ID Sottocategoria (es. 1 per Shampoo, 2 per Balsamo)</label>
                        <input type="number" name="idSottocategoria" value="<%= p.getIdSottocategoria() %>">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group flex-1">
                        <label>Target Cute (es. Grassa, Secca, Tutti)</label>
                        <input type="text" name="tipoCuteTarget" value="<%= (p.getTipoCuteTarget() != null) ? p.getTipoCuteTarget() : "" %>">
                    </div>
                    <div class="form-group flex-1">
                        <label>Target Capello (es. Lisci, Ricci, Tutti)</label>
                        <input type="text" name="tipoCapelloTarget" value="<%= (p.getTipoCapelloTarget() != null) ? p.getTipoCapelloTarget() : "" %>">
                    </div>
                </div>
                
                <div class="checkbox-group">
                    <input type="checkbox" name="isNovita" value="true" id="checkNovita" <%= p.isNovita() ? "checked" : "" %>>
                    <label for="checkNovita" class="checkbox-label">Contrassegna come Novità (Mostra nell'Homepage)</label>
                </div>
                
                <div class="checkbox-group">
                    <input type="checkbox" name="is_attivo" value="true" id="checkAttivo" <%= p.isAttivo() ? "checked" : "" %>>
                    <label for="checkAttivo" class="checkbox-label">Prodotto Attivo (Visibile ai clienti nel catalogo)</label>
                </div>
                
                <div class="form-actions">
                    <a href="<%= request.getContextPath() %>/admin-dashboard" class="link-annulla">Annulla e Torna Indietro</a>
                    <button type="submit" class="btn-salva">Salva Modifiche</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>