<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trova la tua Routine - HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-pubblica">

    <jsp:include page="header.jsp" />

    <%
        List<Prodotto> prodottiConsigliati = (List<Prodotto>) request.getAttribute("prodottiConsigliati");
        String nomeRoutine = (String) request.getAttribute("nomeRoutine");
        String descrizioneRoutine = (String) request.getAttribute("descrizioneRoutine");
        
        if (prodottiConsigliati == null) {
    %>
            <div class="routine-quiz-container">
                <div class="quiz-header">
                    <h2>Il Tuo Rituale su Misura</h2>
                    <p>Rispondi a 2 semplici domande. La nostra scienza formulerà la combinazione perfetta per la tua corona.</p>
                </div>

                <form action="routine" method="POST" class="quiz-form">
                    
                    <div class="quiz-step">
                        <h3>1. Qual è lo stato della tua cute?</h3>
                        <div class="quiz-options">
                            <label class="option-card">
                                <input type="radio" name="cute" value="Grassa" required>
                                <span class="option-content">
                                    <i class="fas fa-tint"></i>
                                    <strong>Grassa</strong>
                                    <small>Tende a sporcarsi facilmente alla radice</small>
                                </span>
                            </label>
                            <label class="option-card">
                                <input type="radio" name="cute" value="Secca / Sensibile">
                                <span class="option-content">
                                    <i class="fas fa-leaf"></i>
                                    <strong>Secca / Sensibile</strong>
                                    <small>Tende a desquamarsi o dare prurito</small>
                                </span>
                            </label>
                            <label class="option-card">
                                <input type="radio" name="cute" value="Normale">
                                <span class="option-content">
                                    <i class="fas fa-check-circle"></i>
                                    <strong>Normale</strong>
                                    <small>Equilibrata, si sporca dopo 3-4 giorni</small>
                                </span>
                            </label>
                        </div>
                    </div>

                    <div class="quiz-step">
                        <h3>2. Qual è la struttura delle tue lunghezze?</h3>
                        <div class="quiz-options">
                            <label class="option-card">
                                <input type="radio" name="capello" value="Lisci" required>
                                <span class="option-content">
                                    <i class="fas fa-bars"></i>
                                    <strong>Lisci</strong>
                                    <small>Senza volume naturale, tendono ad appiattirsi</small>
                                </span>
                            </label>
                            <label class="option-card">
                                <input type="radio" name="capello" value="Ricci o Mossi">
                                <span class="option-content">
                                    <i class="fas fa-ring"></i>
                                    <strong>Ricci o Mossi</strong>
                                    <small>Hanno bisogno di elasticità e controllo del crespo</small>
                                </span>
                            </label>
                            <label class="option-card">
                                <input type="radio" name="capello" value="Trattati / Colorati">
                                <span class="option-content">
                                    <i class="fas fa-magic"></i>
                                    <strong>Trattati / Colorati</strong>
                                    <small>Sottoposti a decolorazioni, tinte o calore estremo</small>
                                </span>
                            </label>
                        </div>
                    </div>

                    <div style="text-align: center; margin-top: 40px;">
                        <button type="submit" class="btn-quiz-submit">Genera la mia Routine ✨</button>
                    </div>
                </form>
            </div>
    <%
        } else {
    %>
            <div class="routine-results-container">
                <div class="results-header">
                    <span class="badge-routine">Diagnosi Completata</span>
                    <h2>La tua Routine: <span style="color: var(--colore-accento);"><%= nomeRoutine %></span></h2>
                    <p class="routine-desc"><%= descrizioneRoutine %></p>
                    <a href="routine" class="btn-Ripeti-quiz"><i class="fas fa-redo"></i> Ripeti il Test</a>
                </div>

                <h3 class="results-title">I tuoi Prodotti Consigliati</h3>
                
                <div class="contenitore-prodotti">
                    <%
                        if (!prodottiConsigliati.isEmpty()) {
                            for (Prodotto p : prodottiConsigliati) {
                    %>
                                <div class="card-prodotto">
                                    <% 
                                        String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                                            ? p.getImmagineUrl() 
                                                            : "https://via.placeholder.com/250x200/1e1e1e/ffffff?text=HairQueen+Product";
                                
                                        if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) {
                                            urlImmagine = "/" + urlImmagine; 
                                        }
                                    %>
                                    <a href="prodotto?id=<%= p.getIdProdotto() %>" style="display: block;">
                                        <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-prodotto">
                                    </a>
                                    <h3>
                                        <a href="prodotto?id=<%= p.getIdProdotto() %>" class="link-titolo-prodotto">
                                            <%= p.getNome() %>
                                        </a>
                                    </h3>
                                    <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                                    <form action="CarrelloServlet" method="POST" style="margin-top: 15px;">
                                        <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                        <button type="submit" class="btn-acquista">Aggiungi al Carrello</button>
                                    </form>
                                </div>
                    <%
                            }
                        } else {
                    %>
                            <p style="grid-column: 1/-1; text-align: center; color: #888;">Nessun prodotto trovato per questa specifica combinazione.</p>
                    <%
                        }
                    %>
                </div>
            </div>
    <%
        }
    %>

    <jsp:include page="footer.jsp" />

</div> 

</body>
</html>