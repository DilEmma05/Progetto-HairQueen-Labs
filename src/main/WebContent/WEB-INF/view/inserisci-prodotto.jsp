<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Inserisci Nuovo Prodotto - Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-admin">
    
    <div class="container container-form">
        <h1 class="titolo-form">Aggiungi al Catalogo</h1>
        
        <form action="<%= request.getContextPath() %>/inserisci-prodotto" method="POST">
            
            <div class="form-group">
                <label for="nome">Nome Prodotto *</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            
            <div class="form-group">
                <label for="descrizione">Descrizione</label>
                <textarea id="descrizione" name="descrizione" rows="4"></textarea>
            </div>
            
            <div class="form-row">
                <div class="form-group flex-1">
                    <label for="prezzo">Prezzo (&euro;) *</label>
                    <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" required>
                </div>
                <div class="form-group flex-1">
                    <label for="quantita">Quantità in Magazzino *</label>
                    <input type="number" id="quantita" name="quantita" min="0" required>
                </div>
            </div>

            <div class="form-group">
                <label for="immagineUrl">URL Immagine</label>
                <input type="text" id="immagineUrl" name="immagineUrl" placeholder="es. images/shampoo-nuovo.jpg">
            </div>
            
            <div class="form-group">
                <label for="faseUtilizzo">Fase di Utilizzo</label>
                <select id="faseUtilizzo" name="faseUtilizzo">
                    <option value="">Seleziona...</option>
                    <option value="Pre-Lavaggio">Pre-Lavaggio</option>
                    <option value="Lavaggio">Lavaggio</option>
                    <option value="Post-Asciugatura">Post-Asciugatura</option>
                    <option value="Styling">Styling</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="tipoCuteTarget">Tipo di Cute Target</label>
                <input type="text" id="tipoCuteTarget" name="tipoCuteTarget" placeholder="es. Grassa, Secca, Sensibile">
            </div>

            <div class="form-group">
                <label for="tipoCapelloTarget">Tipo di Capello Target</label>
                <input type="text" id="tipoCapelloTarget" name="tipoCapelloTarget" placeholder="es. Sottile, Riccio, Trattato">
            </div>
            
            <div class="form-group">
                <label for="idSottocategoria">ID Sottocategoria (Opzionale)</label>
                <input type="number" id="idSottocategoria" name="idSottocategoria" min="1">
            </div>

            <div class="checkbox-group" style="margin-bottom: 10px;">
                <input type="checkbox" name="isNovita" value="true" id="checkNovita">
                <label for="checkNovita" class="checkbox-label">Contrassegna come Novità (Mostra nell'Homepage)</label>
            </div>
            
            <div class="checkbox-group" style="margin-bottom: 25px;">
                <input type="checkbox" name="is_attivo" value="true" id="checkAttivo" checked>
                <label for="checkAttivo" class="checkbox-label">Pubblica Immediatamente (Visibile ai clienti nel catalogo)</label>
            </div>
            <button type="submit" class="btn-submit">Salva Prodotto</button>
        </form>
        
        <a href="<%= request.getContextPath() %>/admin-dashboard" class="back-link">&larr; Torna alla Dashboard</a>
    </div>

</div>

</body>
</html>