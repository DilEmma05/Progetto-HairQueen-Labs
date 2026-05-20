<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Carrello" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il tuo Carrello - HairQueen Labs</title>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0; padding: 0;
        }

        header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid #2C2C2C;
        }
        
        header h1 { color: var(--colore-accento); margin: 0; letter-spacing: 2px; }

        .container-navigazione { max-width: 1000px; margin: 0 auto; padding: 20px; }
        .btn-indietro { color: var(--colore-accento); text-decoration: none; font-weight: bold; }
        .btn-indietro:hover { color: var(--colore-primario); }

        .container-carrello {
            max-width: 1000px;
            margin: 20px auto;
            background-color: var(--sfondo-card);
            padding: 30px;
            border-radius: 8px;
            border: 1px solid #2C2C2C;
        }

        h2 { border-bottom: 2px solid var(--colore-primario); padding-bottom: 10px; margin-top: 0; }

        /* Stile Tabella Carrello */
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #333; }
        th { color: var(--colore-accento); text-transform: uppercase; font-size: 0.9rem; }
        
        .img-carrello { width: 80px; height: 80px; object-fit: contain; border-radius: 4px; }
        .totale-riga { font-weight: bold; color: var(--colore-primario); }

        /* Riepilogo e Bottoni */
        .riepilogo-totale { text-align: right; font-size: 1.5rem; margin-bottom: 20px; }
        .riepilogo-totale span { color: var(--colore-accento); font-weight: bold; }

        .azioni-carrello { display: flex; justify-content: flex-end; gap: 15px; }

        .btn {
            padding: 12px 25px; border: none; border-radius: 4px;
            font-weight: bold; text-transform: uppercase; cursor: pointer; transition: 0.3s;
        }
        .btn-primario { background-color: var(--colore-accento); color: var(--sfondo-principale); }
        .btn-primario:hover { background-color: #bfa030; }
        .btn-secondario { background-color: transparent; color: #ff4d4d; border: 1px solid #ff4d4d; }
        .btn-secondario:hover { background-color: #ff4d4d; color: white; }
    </style>
</head>
<body>

    <header>
        <h1>HAIRQUEEN LABS</h1>
    </header>

    <div class="container-navigazione">
        <a href="home" class="btn-indietro">&larr; Continua lo shopping</a>
    </div>

    <main class="container-carrello">
        <h2>Il tuo Carrello</h2>

        <%
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            
            if (carrello == null || carrello.getElementi().isEmpty()) {
        %>
                <p style="text-align: center; font-size: 1.2rem; color: #888; margin: 40px 0;">Il tuo carrello è attualmente vuoto.</p>
        <%
            } else {
        %>
                <table>
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Dettagli</th>
                            <th>Prezzo Unitario</th>
                            <th>Quantità</th>
                            <th>Totale</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Carrello.ElementoCarrello elemento : carrello.getElementi()) {
                                Prodotto p = elemento.getProdotto();
                                
                                String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) ? p.getImmagineUrl() : "https://via.placeholder.com/80/1e1e1e/ffffff";
                                if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) { urlImmagine = "/" + urlImmagine; }
                        %>
                                <tr>
                                    <td><img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-carrello"></td>
                                    <td style="font-weight: bold;"><%= p.getNome() %></td>
                                    <td>&euro; <%= String.format("%.2f", p.getPrezzo()) %></td>
                                    <td><%= elemento.getQuantita() %></td>
                                    <td class="totale-riga">&euro; <%= String.format("%.2f", p.getPrezzo() * elemento.getQuantita()) %></td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <div class="riepilogo-totale">
                    Totale Carrello: <span>&euro; <%= String.format("%.2f", carrello.getPrezzoTotale()) %></span>
                </div>

                <div class="azioni-carrello">
    			<form action="svuota-carrello" method="POST" style="margin: 0;">
        		<button type="submit" class="btn btn-secondario">Svuota Carrello</button>
    			</form>
    
    			<a href="checkout" class="btn btn-primario" style="text-decoration: none; display: inline-block; text-align: center;">Procedi al Checkout</a>
				</div>
        <%
            }
        %>
    </main>

</body>
</html>