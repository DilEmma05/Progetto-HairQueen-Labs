<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Carrello" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - HairQueen Labs</title>
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
            margin: 0; padding: 0;
        }

        header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid #2C2C2C;
        }
        header h1 { color: var(--colore-accento); margin: 0; letter-spacing: 2px; }

        .container-checkout {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
        }

        .sezione-dati {
            flex: 2;
            min-width: 350px;
            background-color: var(--sfondo-card);
            padding: 30px;
            border-radius: 8px;
            border: 1px solid #2C2C2C;
        }

        .sezione-riepilogo {
            flex: 1;
            min-width: 300px;
            background-color: var(--sfondo-card);
            padding: 30px;
            border-radius: 8px;
            border: 1px solid #2C2C2C;
            height: fit-content;
        }

        h2 { border-bottom: 2px solid var(--colore-primario); padding-bottom: 10px; margin-top: 0; font-size: 1.5rem; }

        /* Stile Form */
        .gruppo-form { margin-bottom: 20px; }
        .gruppo-form label { display: block; margin-bottom: 8px; color: #bbb; font-size: 0.9rem; }
        .gruppo-form input, .gruppo-form select {
            width: 100%; padding: 12px; border: 1px solid #333; background-color: #121212;
            color: white; border-radius: 4px; box-sizing: border-box; font-size: 1rem;
        }
        .gruppo-form input:focus, .gruppo-form select:focus { border-color: var(--colore-accento); outline: none; }

        .riga-doppia { display: flex; gap: 20px; }
        .riga-doppia .gruppo-form { flex: 1; }

        /* Elementi riepilogo */
        .item-riepilogo { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 0.95rem; color: #ccc; }
        .totale-finalizzato { display: flex; justify-content: space-between; font-size: 1.4rem; font-weight: bold; border-top: 1px solid #333; padding-top: 15px; margin-top: 15px; color: var(--colore-accento); }

        .btn-conferma {
            width: 100%; background-color: var(--colore-accento); color: var(--sfondo-principale);
            border: none; padding: 15px; font-size: 1.1rem; font-weight: bold; border-radius: 4px;
            cursor: pointer; text-transform: uppercase; margin-top: 20px; transition: 0.3s;
        }
        .btn-conferma:hover { background-color: #bfa030; }
    </style>
</head>
<body>

    <header>
        <h1>HAIRQUEEN LABS</h1>
    </header>

    <main class="container-checkout">
        <%
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            if (carrello != null && !carrello.getElementi().isEmpty()) {
        %>
            <section class="sezione-dati">
                <h2>Informazioni di Spedizione</h2>
                <form action="ConfermaOrdine" method="POST" id="form-checkout">
                    <div class="riga-doppia">
                        <div class="gruppo-form">
                            <label for="nome">Nome</label>
                            <input type="text" id="nome" name="nome" required>
                        </div>
                        <div class="gruppo-form">
                            <label for="cognome">Cognome</label>
                            <input type="text" id="cognome" name="cognome" required>
                        </div>
                    </div>

                    <div class="gruppo-form">
                        <label for="indirizzo">Indirizzo e Numero Civico</label>
                        <input type="text" id="indirizzo" name="indirizzo" required>
                    </div>

                    <div class="riga-doppia">
                        <div class="gruppo-form">
                            <label for="citta">Città</label>
                            <input type="text" id="citta" name="citta" required>
                        </div>
                        <div class="gruppo-form">
                            <label for="cap">CAP</label>
                            <input type="text" id="cap" name="cap" pattern="[0-9]{5}" required>
                        </div>
                    </div>

                    <div class="gruppo-form">
                        <label for="telefono">Telefono</label>
                        <input type="tel" id="telefono" name="telefono" required>
                    </div>

                    <h2>Metodo di Pagamento</h2>
                    <div class="gruppo-form">
                        <label for="pagamento">Scegli una modalità</label>
                        <select id="pagamento" name="metodoPagamento" required>
                            <option value="Carta">Carta di Credito / Debito</option>
                            <option value="PayPal">PayPal</option>
                            <option value="Contrassegno">Contrassegno alla consegna</option>
                        </select>
                    </div>
                </form>
            </section>

            <section class="sezione-riepilogo">
                <h2>Riepilogo Ordine</h2>
                <div style="margin-bottom: 20px; max-height: 200px; overflow-y: auto; padding-right: 5px;">
                    <%
                        for (Carrello.ElementoCarrello elemento : carrello.getElementi()) {
                            Prodotto p = elemento.getProdotto();
                    %>
                            <div class="item-riepilogo">
                                <span><%= p.getNome() %> (x<%= elemento.getQuantita() %>)</span>
                                <span>&euro; <%= String.format("%.2f", p.getPrezzo() * elemento.getQuantita()) %></span>
                            </div>
                    <%
                        }
                    %>
                </div>

                <div class="item-riepilogo">
                    <span>Spedizione</span>
                    <span style="color: #2ecc71; font-weight: bold;">Gratuita</span>
                </div>

                <div class="totale-finalizzato">
                    <span>Totale:</span>
                    <span>&euro; <%= String.format("%.2f", carrello.getPrezzoTotale()) %></span>
                </div>

                <button type="submit" form="form-checkout" class="btn-conferma">Completa l'Ordine</button>
            </section>
        <%
            }
        %>
    </main>

</body>
</html>