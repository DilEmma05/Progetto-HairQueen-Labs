<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%@ page import="it.unisa.hairqueenlabs.model.Recensione" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettaglio Prodotto - HairQueen Labs</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<div class="area-pubblica">

    <jsp:include page="header.jsp" />

    <div class="area-dettaglio">

        <div class="container-navigazione">
            <a href="<%= request.getContextPath() %>/home" class="btn-indietro">&larr; Torna al Catalogo</a>
        </div>

        <%
            Prodotto p = (Prodotto) request.getAttribute("prodotto");
            List<Recensione> recensioni = (List<Recensione>) request.getAttribute("recensioni");
            Utente utenteLoggato = (Utente) session.getAttribute("utente");
            
            if (p != null) {
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
                        
                        <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-ajax-carrello">
                            <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                            <button type="submit" class="btn-aggiungi">Aggiungi al Carrello</button>
                        </form>
                    </div>
                </main>
                
                <div class="sezione-recensioni">
                    
                    <% if ("recensioneInserita".equals(request.getParameter("successo"))) { %>
                        <div class="alert alert-success recensione-alert">
                            &#10004; Grazie! La tua recensione è stata pubblicata con successo.
                        </div>
                    <% } %>

                    <h3>Recensioni dei Clienti</h3>

                    <% if (recensioni != null && !recensioni.isEmpty()) { %>
                        <div class="lista-recensioni">
                            <% for (Recensione r : recensioni) { %>
                                <div class="recensione-item">
                                    <p class="recensione-autore">
                                        <strong><%= r.getNomeUtente() %></strong> - 
                                        <span class="stelle-valutazione">
                                            <%= "★".repeat(r.getVoto()) %><%= "☆".repeat(5 - r.getVoto()) %>
                                        </span>
                                    </p>
                                    <p class="recensione-testo">
                                        <%= (r.getTesto() != null && !r.getTesto().trim().isEmpty()) ? r.getTesto() : "Nessun commento scritto." %>
                                    </p>
                                    <small class="recensione-data">
                                        <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(r.getDataRecensione()) %>
                                    </small>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <p class="nessuna-recensione">Non ci sono ancora recensioni per questo prodotto. Sii il primo a lasciarne una!</p>
                    <% } %>

                    <div class="nuova-recensione-box">
                        <% if (utenteLoggato != null) { %>
                            <h4>Lascia una recensione</h4>
                            <form action="<%= request.getContextPath() %>/inserisci-recensione" method="POST">
                                <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                
                                <div class="form-group form-recensione-voto">
                                    <label style="display: block; margin-bottom: 10px; font-weight: bold;">Valutazione: </label>
                                    <div class="star-rating">
                                        <!-- Ordine inverso nel codice per far funzionare il trucco CSS -->
                                        <input type="radio" id="star5" name="voto" value="5" required />
                                        <label for="star5" title="5 Stelle - Eccellente"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star4" name="voto" value="4" />
                                        <label for="star4" title="4 Stelle - Ottimo"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star3" name="voto" value="3" />
                                        <label for="star3" title="3 Stelle - Buono"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star2" name="voto" value="2" />
                                        <label for="star2" title="2 Stelle - Sufficiente"><i class="fas fa-star"></i></label>
                                        
                                        <input type="radio" id="star1" name="voto" value="1" />
                                        <label for="star1" title="1 Stella - Scarso"><i class="fas fa-star"></i></label>
                                    </div>
                                </div>
                                
                                <div class="form-group form-recensione-testo">
                                    <label for="testo">Il tuo commento:</label>
                                    <textarea name="testo" id="testo" rows="4" placeholder="Raccontaci la tua esperienza con questo prodotto..."></textarea>
                                </div>
                                
                                <button type="submit" class="btn-aggiungi btn-invio-recensione">Pubblica Recensione</button>
                            </form>
                        <% } else { %>
                            <p class="avviso-login-recensione">
                                <a href="<%= request.getContextPath() %>/login">Accedi</a> o 
                                <a href="<%= request.getContextPath() %>/registrazione">Registrati</a> 
                                per lasciare una recensione su questo prodotto.
                            </p>
                        <% } %>
                    </div>
                </div>
                <%
            } else {
        %>
                <div class="prodotto-non-trovato">
                    <h2>Errore!</h2>
                    <p>Il prodotto che stai cercando non esiste o è stato rimosso.</p>
                </div>
        <%
            }
        %>

    </div> 
</div> 

<script src="<%= request.getContextPath() %>/scripts/ajax-carrello.js"></script>

</body>
</html>