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
            --colore-errore: #e74c3c; /* Rosso per gli errori */
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

        .sezione-dati, .sezione-riepilogo {
            background-color: var(--sfondo-card);
            padding: 30px;
            border-radius: 8px;
            border: 1px solid #2C2C2C;
        }

        .sezione-dati { flex: 2; min-width: 350px; }
        .sezione-riepilogo { flex: 1; min-width: 300px; height: fit-content; }

        h2 { border-bottom: 2px solid var(--colore-primario); padding-bottom: 10px; margin-top: 0; font-size: 1.5rem; }

        /* Stile Form e Validazione */
        .gruppo-form { margin-bottom: 20px; }
        .gruppo-form label { display: block; margin-bottom: 8px; color: #bbb; font-size: 0.9rem; }
        .asterisco { color: var(--colore-errore); font-weight: bold; margin-left: 3px; }
        
        .gruppo-form input, .gruppo-form select {
            width: 100%; padding: 12px; border: 1px solid #333; background-color: #121212;
            color: white; border-radius: 4px; box-sizing: border-box; font-size: 1rem;
            transition: border-color 0.3s;
        }
        .gruppo-form input:focus, .gruppo-form select:focus { border-color: var(--colore-accento); outline: none; }

        /* CSS attivato da JavaScript solo dopo che l'utente ha provato a cliccare Checkout */
        .form-tentato input:invalid, 
        .form-tentato select:invalid {
            border-color: var(--colore-errore);
            background-color: rgba(231, 76, 60, 0.05); /* Leggero sfondo rosso */
        }

        .riga-doppia { display: flex; gap: 20px; }
        .riga-doppia .gruppo-form { flex: 1; }

        .item-riepilogo { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 0.95rem; color: #ccc; }
        .totale-finalizzato { display: flex; justify-content: space-between; font-size: 1.4rem; font-weight: bold; border-top: 1px solid #333; padding-top: 15px; margin-top: 15px; color: var(--colore-accento); }

        .btn-conferma {
            width: 100%; background-color: var(--colore-accento); color: var(--sfondo-principale);
            border: none; padding: 15px; font-size: 1.1rem; font-weight: bold; border-radius: 4px;
            cursor: pointer; text-transform: uppercase; margin-top: 20px; transition: 0.3s;
        }
        .btn-conferma:hover { background-color: #bfa030; }

        /* Messaggio di Errore Nascosto di Default */
        #messaggio-errore {
            display: none;
            color: var(--colore-errore);
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
            font-size: 0.95rem;
        }
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
                <form action="ConfermaOrdine" method="POST" id="form-checkout" novalidate>
                    <div class="riga-doppia">
                        <div class="gruppo-form">
                            <label for="nome">Nome <span class="asterisco">*</span></label>
                            <input type="text" id="nome" name="nome" required>
                        </div>
                        <div class="gruppo-form">
                            <label for="cognome">Cognome <span class="asterisco">*</span></label>
                            <input type="text" id="cognome" name="cognome" required>
                        </div>
                    </div>

                    <div class="gruppo-form">
                        <label for="indirizzo">Indirizzo e Numero Civico <span class="asterisco">*</span></label>
                        <input type="text" id="indirizzo" name="indirizzo" required>
                    </div>

                    <div class="riga-doppia">
                        <div class="gruppo-form">
                            <label for="citta">Città <span class="asterisco">*</span></label>
                            <input type="text" id="citta" name="citta" required>
                        </div>
                        <div class="gruppo-form">
                            <label for="cap">CAP <span class="asterisco">*</span></label>
                            <input type="text" id="cap" name="cap" pattern="[0-9]{5}" required>
                        </div>
                    </div>

                    <div class="gruppo-form">
                        <label for="telefono">Telefono <span class="asterisco">*</span></label>
                        <input type="tel" id="telefono" name="telefono" required>
                    </div>

                    <h2>Metodo di Pagamento</h2>
                    <div class="gruppo-form">
                        <label for="pagamento">Scegli una modalità <span class="asterisco">*</span></label>
                        <select id="pagamento" name="metodoPagamento" required>
                            <option value="">-- Seleziona --</option>
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
                
                <div id="messaggio-errore">Errore: inserire tutti i dati obbligatori nel form per procedere.</div>
            </section>
        <%
            } else {
        %>
            <div style="text-align:center; width:100%; margin-top: 50px;">
                <h2>Il tuo carrello è vuoto.</h2>
                <a href="home" style="color: var(--colore-accento); text-decoration: none;">Torna agli acquisti</a>
            </div>
        <%
            }
        %>
    </main>

    <script>
        document.getElementById('form-checkout').addEventListener('submit', function(event) {
            // Controlla se ci sono campi non compilati o non validi
            if (!this.checkValidity()) {
                // Blocca l'invio del form alla Servlet
                event.preventDefault(); 
                
                // Aggiunge la classe che fa diventare rossi i campi vuoti
                this.classList.add('form-tentato'); 
                
                // Mostra il messaggio di errore sotto il bottone
                document.getElementById('messaggio-errore').style.display = 'block'; 
            }
        });
    </script>
</body>
</html>