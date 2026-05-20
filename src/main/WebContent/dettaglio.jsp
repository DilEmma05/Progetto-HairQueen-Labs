<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettaglio Prodotto - HairQueen Labs</title>
    
    <style>
        :root {
            --sfondo-principale: #121212;
            --testo-principale: #F5F5F5;
            --colore-primario: #8E44AD; /* Viola Ametista */
            --colore-accento: #D4AF37;   /* Oro Luxury */
            --sfondo-card: #1E1E1E;
        }

        body {
            background-color: var(--sfondo-principale);
            color: var(--testo-principale);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid #2C2C2C;
        }
        
        header h1 {
            color: var(--colore-accento);
            margin: 0;
            font-size: 2.5rem;
            letter-spacing: 2px;
        }

        .container-navigazione {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .btn-indietro {
            color: var(--colore-accento);
            text-decoration: none;
            font-weight: bold;
            font-size: 1.1rem;
            transition: color 0.3s;
        }

        .btn-indietro:hover {
            color: var(--colore-primario);
        }

        /* Layout Dettaglio a due colonne */
        .container-dettaglio {
            max-width: 1000px;
            margin: 0 auto 50px auto;
            padding: 0 20px;
            display: flex;
            gap: 50px;
            flex-wrap: wrap; /* Per adattarsi agli schermi più piccoli */
        }

        .colonna-sinistra {
            flex: 1;
            min-width: 300px;
            background-color: var(--sfondo-card);
            border-radius: 8px;
            padding: 30px;
            border: 1px solid #2C2C2C;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .colonna-sinistra img {
            max-width: 100%;
            max-height: 500px;
            object-fit: contain; /* Non deforma il flacone */
            border-radius: 4px;
        }

        .colonna-destra {
            flex: 1;
            min-width: 300px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .colonna-destra h2 {
            font-size: 2.5rem;
            margin: 0 0 15px 0;
            border-bottom: 2px solid var(--colore-primario);
            padding-bottom: 15px;
        }

        .colonna-destra .prezzo {
            color: var(--colore-accento);
            font-size: 2rem;
            font-weight: bold;
            margin: 20px 0;
        }

        .colonna-destra .descrizione {
            line-height: 1.8;
            color: #d1d1d1;
            font-size: 1.1rem;
            margin-bottom: 40px;
        }

        .btn-aggiungi {
            background-color: var(--colore-accento);
            color: var(--sfondo-principale);
            border: none;
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            text-transform: uppercase;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        .btn-aggiungi:hover {
            background-color: #bfa030;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <header>
        <h1>HAIRQUEEN LABS</h1>
    </header>

    <div class="container-navigazione">
        <a href="home" class="btn-indietro">&larr; Torna al Catalogo</a>
    </div>

    <%
        // Recuperiamo il prodotto passato dalla DettaglioProdottoServlet
        Prodotto p = (Prodotto) request.getAttribute("prodotto");
        
        if (p != null) {
            // Gestione sicura del percorso dell'immagine
            String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                 ? p.getImmagineUrl() 
                                 : "https://via.placeholder.com/450x500/1e1e1e/ffffff?text=HairQueen+Product";
            
            if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) {
                urlImmagine = "/" + urlImmagine; 
            }
    %>
            <main class="container-dettaglio">
                <div class="colonna-sinistra">
                    <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>">
                </div>
                
                <div class="colonna-destra">
                    <h2><%= p.getNome() %></h2>
                    <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                    
                    <p class="descrizione">
                        <%= p.getDescrizione() != null && !p.getDescrizione().isEmpty() 
                            ? p.getDescrizione() 
                            : "Vizia i tuoi capelli con questo esclusivo trattamento HairQueen Labs. La descrizione dettagliata per questo prodotto di lusso sarà disponibile a breve." %>
                    </p>
                    
                    <form action="CarrelloServlet" method="POST">
                        <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                        <button type="submit" class="btn-aggiungi">Aggiungi al Carrello</button>
                    </form>
                </div>
            </main>
    <%
        } else {
    %>
            <div style="text-align:center; margin-top: 50px;">
                <h2 style="color: red;">Errore!</h2>
                <p>Il prodotto che stai cercando non esiste o è stato rimosso.</p>
            </div>
    <%
        }
    %>

</body>
</html>