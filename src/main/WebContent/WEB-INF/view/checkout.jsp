<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Carrello" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - HairQueen Labs</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-checkout">

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
                <form action="<%= request.getContextPath() %>/ConfermaOrdine" method="POST" id="form-checkout" novalidate>
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
                
                <div class="lista-riepilogo">
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
                    <span class="spedizione-gratis">Gratuita</span>
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
            <div class="carrello-vuoto-checkout">
                <h2>Il tuo carrello è vuoto.</h2>
                <a href="<%= request.getContextPath() %>/home">Torna agli acquisti</a>
            </div>
        <%
            }
        %>
    </main>

</div> <script src="<%= request.getContextPath() %>/scripts/checkout.js"></script>
</body>
</html>