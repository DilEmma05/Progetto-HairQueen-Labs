<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Categoria" %>
<%@ page import="it.unisa.hairqueenlabs.dao.CategoriaDAO" %>
<%@ page import="it.unisa.hairqueenlabs.model.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supporto e Info - HairQueen Labs</title>
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
        <a href="carrello" class="link-carrello">🛒 Carrello</a>
        <%
            Utente utente = (Utente) session.getAttribute("utente");
            if (utente == null) {
        %>
                <a href="login" class="btn-login">Accedi</a>
        <%
            } else {
        %>
                <div class="menu-utente-loggato">
                    <a href="profilo" class="link-profilo">Ciao, <strong><%= utente.getNome() %></strong></a>
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
            // SALVAGENTE: Se navighiamo qui direttamente, request.getAttribute è null.
            // In tal caso, chiediamo al DAO di estrarre le categorie al volo!
            it.unisa.hairqueenlabs.dao.CategoriaDAO catDAO = new it.unisa.hairqueenlabs.dao.CategoriaDAO();
            List<Categoria> macroCategorie = (List<Categoria>) request.getAttribute("listaCategorie");
            
            if (macroCategorie == null) {
                try {
                    macroCategorie = catDAO.doRetrieveAllCategorie();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if (macroCategorie != null) {
                for (Categoria cat : macroCategorie) {
        %>
                    <li>
                        <a href="FiltroCatalogoServlet?id=<%= cat.getIdCategoria() %>">
                            <%= cat.getNomeCategoria() %> <i class="fa fa-caret-down"></i>
                        </a>

                        <div class="dropdown-content">
                            <%
                                try {
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
                                } catch (Exception e) {
                                    e.printStackTrace();
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

    <div style="background-color: #1a1a1a; padding: 40px 20px; text-align: center; margin-bottom: 30px;">
        <h2 style="color: var(--colore-accento); font-size: 2.2rem; letter-spacing: 2px; margin: 0;">Customer Care</h2>
        <p style="color: #bbb; font-size: 1.1rem; margin-top: 10px;">Siamo qui per garantirti un'esperienza di acquisto impeccabile.</p>
    </div>

    <main class="contenitore-info">
        
        <section id="spedizioni" class="info-section">
            <h3><i class="fas fa-box"></i> Spedizioni e Resi</h3>
            <p>Tutti gli ordini HairQueen Labs vengono elaborati entro 24 ore lavorative. Offriamo la <strong>spedizione Express gratuita</strong> per ordini superiori a 150&euro;. Riceverai il tuo rituale di bellezza in un packaging protettivo e lussuoso, progettato per preservare l'integrità delle formulazioni e l'ingegneria dei nostri strumenti.</p>
            <p>Se non sei completamente soddisfatta del tuo acquisto, puoi effettuare un reso gratuito entro 30 giorni dalla ricezione. Consulta la tua area personale per avviare la procedura di reso.</p>
        </section>

        <section id="faq" class="info-section">
            <h3><i class="fas fa-question-circle"></i> Domande Frequenti (FAQ)</h3>
            <div class="faq-item">
                <h4>I vostri strumenti danneggiano i capelli?</h4>
                <p>No. I nostri strumenti di styling utilizzano sensori termici di ultima generazione che misurano la temperatura del flusso d'aria decine di volte al secondo, prevenendo i danni da calore estremo.</p>
            </div>
            <div class="faq-item">
                <h4>Come scelgo la routine adatta a me?</h4>
                <p>Ti invitiamo a utilizzare la nostra pagina "Trova Routine ✨" per scoprire i prodotti perfetti in base alla porosità e alle esigenze della tua chioma.</p>
            </div>
        </section>

        <section id="contatti" class="info-section">
            <h3><i class="fas fa-envelope"></i> Contattaci</h3>
            <p>I nostri esperti di bellezza e il nostro supporto tecnico sono a tua completa disposizione.</p>
            <ul>
                <li><strong>Email:</strong> support@hairqueenlabs.it</li>
                <li><strong>Telefono:</strong> +39 800 123 456 (Lun - Ven, 09:00 - 18:00)</li>
            </ul>
        </section>

        <section id="condizioni" class="info-section">
            <h3><i class="fas fa-file-contract"></i> Condizioni di Vendita</h3>
            <p>Le presenti condizioni generali di vendita disciplinano l'acquisto dei prodotti sul nostro sito. L'acquisto di strumentazione elettronica è coperto da garanzia legale di 24 mesi per difetti di conformità.</p>
            <p><em>*Nota per il progetto universitario: Le informazioni presenti in questa pagina sono puramente a scopo dimostrativo per la simulazione dell'ambiente e-commerce.</em></p>
        </section>

    </main>

    <jsp:include page="footer.jsp" />

</div> 

</body>
</html>