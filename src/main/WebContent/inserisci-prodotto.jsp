<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>

<%
    // Sicurezza: doppio controllo lato View per il Pattern MVC
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"ADMIN".equals(utente.getRuolo())) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Inserisci Nuovo Prodotto - Admin</title>
    <style>
        body { background-color: #121212; color: #F5F5F5; font-family: sans-serif; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; background-color: #1E1E1E; padding: 30px; border-radius: 8px; }
        h1 { color: #e74c3c; border-bottom: 2px solid #333; padding-bottom: 10px; text-align: center; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #bbb; }
        input[type="text"], input[type="number"], textarea, select { 
            width: 100%; padding: 10px; background-color: #333; color: white; border: 1px solid #555; border-radius: 4px; box-sizing: border-box; 
        }
        .btn-submit { background-color: #e74c3c; color: white; border: none; padding: 12px 20px; width: 100%; border-radius: 4px; font-weight: bold; cursor: pointer; font-size: 16px; margin-top: 10px; }
        .btn-submit:hover { background-color: #c0392b; }
        .back-link { display: block; text-align: center; margin-top: 20px; color: #888; text-decoration: none; }
    </style>
</head>
<body>

<div class="container">
    <h1>Aggiungi al Catalogo</h1>
    
    <form action="inserisci-prodotto" method="POST">
        
        <div class="form-group">
            <label for="nome">Nome Prodotto *</label>
            <input type="text" id="nome" name="nome" required>
        </div>
        
        <div class="form-group">
            <label for="descrizione">Descrizione</label>
            <textarea id="descrizione" name="descrizione" rows="4"></textarea>
        </div>
        
        <div style="display: flex; gap: 15px;">
            <div class="form-group" style="flex: 1;">
                <label for="prezzo">Prezzo (&euro;) *</label>
                <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" required>
            </div>
            <div class="form-group" style="flex: 1;">
                <label for="quantita">Quantità in Magazzino *</label>
                <input type="number" id="quantita" name="quantita" min="0" required>
            </div>
        </div>

        <div class="form-group">
            <label for="immagineUrl">URL Immagine</label>
            <input type="text" id="immagineUrl" name="immagineUrl" placeholder="es. img/shampoo-nuovo.jpg">
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

        <button type="submit" class="btn-submit">Salva Prodotto</button>
    </form>
    
    <a href="admin-dashboard" class="back-link">&larr; Torna alla Dashboard</a>
</div>

</body>
</html>