<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%@ page import="it.unisa.hairqueenlabs.model.Categoria" %>
<%@ page import="it.unisa.hairqueenlabs.dao.CategoriaDAO" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-pubblica">

    <header>
        <h1>HAIRQUEEN LABS</h1>
        <p>Benvenuti nel tempio della cura dei tuoi capelli</p>
    </header>
    
    <div class="barra-utente">
        
        <a href="carrello" class="link-carrello">
            🛒 Carrello
        </a>

        <%
            Utente utente = (Utente) session.getAttribute("utente");
            if (utente == null) {
        %>
                <a href="login" class="btn-login">Accedi</a>
        <%
            } else {
        %>
                <div class="menu-utente-loggato">
                    <a href="profilo" class="link-profilo">
                        Ciao, <strong><%= utente.getNome() %></strong>
                    </a>
                    <a href="logout" class="btn-logout">Esci</a>
                </div>
        <%
            }
        %>
    </div>

    <nav>
        <ul>
        <li><a href="home#ultimi-arrivi">Novità</a></li>
        
        <li><a href="catalogo">Tutti i Prodotti</a></li>
        
        <%
            List<Categoria> macroCategorie = (List<Categoria>) request.getAttribute("listaCategorie");
            it.unisa.hairqueenlabs.dao.CategoriaDAO catDAO = new CategoriaDAO();

            if (macroCategorie != null) {
                for (Categoria cat : macroCategorie) {
        %>
                    <li>
                        <a href="FiltroCatalogoServlet?id=<%= cat.getIdCategoria() %>">
                            <%= cat.getNomeCategoria() %> <i class="fa fa-caret-down"></i>
                        </a>

                        <div class="dropdown-content">
                            <%
                                List<it.unisa.hairqueenlabs.model.Sottocategoria> sottoCats = 
                                    catDAO.doRetrieveSottocategorie(cat.getIdCategoria());
                                
                                if (sottoCats != null) {
                                    for (it.unisa.hairqueenlabs.model.Sottocategoria s : sottoCats) {
                            %>
                                        <a href="FiltroSottocategoriaServlet?id=<%= s.getIdSottocategoria() %>">
                                            <%= s.getNomeSottocategoria() %>
                                        </a>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </li>
        <%
                }
            }
        %>
        <li><a href="routine">Trova Routine ✨</a></li>
    </ul>
    </nav>
    
    <section class="hero-carousel">
        
        <div class="carousel-track-container">
            <ul class="carousel-track">
                
                <li class="carousel-slide current-slide">
    				<img class="carousel-image" src="<%= request.getContextPath() %>/img/layout/uso_phon_hairqueenlabs.png" alt="Modella con capelli dinamici in salone">
    					<div class="hero-content">
        					<h2>Il futuro dei tuoi<br>capelli inizia qui.</h2>
        					<p>Formulazioni premium per una routine di lusso.<br>Risultati da salone, direttamente a casa tua.</p>
        					<a href="routine" class="btn-hero">Scopri la Tua Routine ✨</a>
    					</div>
				</li>

				<li class="carousel-slide">
    				<img class="carousel-image" src="<%= request.getContextPath() %>/img/layout/rituali_cura_capelli.png" alt="Applicazione prodotto di lusso">
    					<div class="hero-content">
        					<h2>Vizia te stessa.</h2>
        					<p>Rituali di cura esclusivi per ogni tipo di capello.</p>
        					<a href="home" class="btn-hero">Esplora il Catalogo</a>
    					</div>
				</li>
				
				<li class="carousel-slide">
                    <img class="carousel-image" src="<%= request.getContextPath() %>/img/promo_phon_piastra_capelli.png" alt="Bundle paistra phon">
                    <div class="hero-content">
                        <h2>Il Lusso Senza<br>Compromessi.</h2>
                        <p>Scopri la nostra visione di lusso e cura esclusiva.<br>Esplora il rituale perfetto per te.</p>
                        <a href="prodotto?id=14" class="btn-hero">Acquista la Promo</a>
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

    <h2 id="ultimi-arrivi" style="text-align: center; color: var(--colore-accento); margin-top: 60px; margin-bottom: 10px; font-size: 2.5rem; letter-spacing: 1px;">Le Nostre Novità</h2>

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
                <p style="grid-column: 1/-1; text-align: center; color: #888;">
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
            <a href="laboratori" class="btn-outline">Scopri la nostra tecnologia</a>
        </div>
        <div class="philosophy-image">
            <img src="<%= request.getContextPath() %>/img/layout/filosofia_laboratori.png" alt="Laboratori HairQueen">
        </div>
    </section>
    
    <jsp:include page="footer.jsp" />

</div> 

<script src="js/hero.js"></script>
</body>
</html>