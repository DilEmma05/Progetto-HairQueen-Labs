<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-pubblica">

<jsp:include page="header.jsp"/>
    
    <section class="hero-carousel">
        
        <div class="carousel-track-container">
            <ul class="carousel-track">
                
                <li class="carousel-slide current-slide">
                    <img class="carousel-image" src="<%= request.getContextPath() %>/images/layout/uso_phon_hairqueenlabs.png" alt="Modella con capelli dinamici in salone">
                        <div class="hero-content">
                            <h2>Il futuro dei tuoi<br>capelli inizia qui.</h2>
                            <p>Formulazioni premium per una routine di lusso.<br>Risultati da salone, direttamente a casa tua.</p>
                            <a href="<%= request.getContextPath() %>/routine" class="btn-hero">Scopri la Tua Routine ✨</a>
                        </div>
                </li>

                <li class="carousel-slide">
                    <img class="carousel-image" src="<%= request.getContextPath() %>/images/layout/rituali_cura_capelli.png" alt="Applicazione prodotto di lusso">
                        <div class="hero-content">
                            <h2>Vizia te stessa.</h2>
                            <p>Rituali di cura esclusivi per ogni tipo di capello.</p>
                            <a href="<%= request.getContextPath() %>/home" class="btn-hero">Esplora il Catalogo</a>
                        </div>
                </li>
                
                <li class="carousel-slide">
                    <img class="carousel-image" src="<%= request.getContextPath() %>/images/promo_phon_piastra_capelli.png" alt="Bundle paistra phon">
                    <div class="hero-content">
                        <h2>Il Lusso Senza<br>Compromessi.</h2>
                        <p>Scopri la nostra visione di lusso e cura esclusiva.<br>Esplora il rituale perfetto per te.</p>
                        <a href="<%= request.getContextPath() %>/prodotto?id=14" class="btn-hero">Acquista la Promo</a>
                    </div>
                </li>

            </ul>
        </div>

        <button class="carousel-button carousel-button-left is-hidden">
            <i class="fa fa-chevron-left"></i>
        </button>
        <button class="carousel-button carousel-button-right">
            <i class="fa fa-chevron-right"></i>
        </button>

        <div class="carousel-nav">
            <button class="carousel-indicator current-slide"></button>
            <button class="carousel-indicator"></button>
            <button class="carousel-indicator"></button>
        </div>
    </section>

    <h2 id="ultimi-arrivi" class="titolo-sezione-novita">Le Nostre Novità</h2>

    <main class="contenitore-prodotti">
        <%
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("listaProdotti");
            
            if (prodotti != null && !prodotti.isEmpty()) {
                for (Prodotto p : prodotti) {
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
            
                    <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-immagine-prodotto">
                        <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-prodotto">
                    </a>
            
                    <h3>
                        <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-titolo-prodotto">
                        <%= p.getNome() %>
                        </a>
                    </h3>
                    <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-ajax-carrello">
                        <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                        <button type="submit" class="btn-acquista">Aggiungi al Carrello</button>
                    </form>
                </div>
        <%
                }
            } else {
        %>
                <p class="messaggio-catalogo-vuoto">
                    Nessun prodotto disponibile nel catalogo. Assicurati di avviare il sito tramite l'URL della Servlet (/home)!
                </p>
        <%
            }
        %>
    </main>
    
    <section class="brand-philosophy">
        <div class="philosophy-text">
            <h2>Scienza e Lusso per la tua Corona.</h2>
            <p>In HairQueen Labs crediamo che ogni capello meriti l'eccellenza. Uniamo l'ingegneria più avanzata alle formulazioni più esclusive per offrirti non solo un prodotto, ma un vero e proprio rituale di bellezza. La vera rivoluzione nasce nei nostri laboratori e prende vita sulla tua chioma.</p>
            <a href="<%= request.getContextPath() %>/laboratori" class="btn-outline">Scopri la nostra tecnologia</a>
        </div>
        <div class="philosophy-image">
            <img src="<%= request.getContextPath() %>/images/layout/filosofia_laboratori.png" alt="Laboratori HairQueen">
        </div>
    </section>
    
    <jsp:include page="footer.jsp" />

</div> 

<script src="<%= request.getContextPath() %>/scripts/hero.js"></script>
<script src="<%= request.getContextPath() %>/scripts/ajax-carrello.js"></script>
</body>
</html>