<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="site-footer">
    <div class="footer-container">
        
        <div class="footer-col brand-col">
            <h3>HAIRQUEEN LABS</h3>
            <p>Il lusso della scienza, la bellezza della tua corona.</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-tiktok"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>

        <div class="footer-col">
            <h4>Esplora</h4>
            <ul>
                <li><a href="home">Home</a></li>
                <li><a href="catalogo">Tutti i Prodotti</a></li>
                <li><a href="FiltroCatalogoServlet?id=1">Cura dei Capelli</a></li>
                <li><a href="FiltroCatalogoServlet?id=2">Strumenti di Styling</a></li>
                <li><a href="FiltroCatalogoServlet?id=3">Bundle</a></li>
                <li><a href="routine">Trova Routine</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h4>Supporto</h4>
            <ul>
                <li><a href="#">Spedizioni e Resi</a></li>
                <li><a href="#">Domande Frequenti (FAQ)</a></li>
                <li><a href="#">Contattaci</a></li>
                <li><a href="#">Condizioni di Vendita</a></li>
            </ul>
        </div>

        <div class="footer-col newsletter-col">
            <h4>Privilege Club</h4>
            <p>Iscriviti per lanci esclusivi e consigli di stile.</p>
            <form action="#" class="newsletter-form">
                <input type="email" placeholder="Il tuo indirizzo email..." required>
                <button type="submit"><i class="fas fa-arrow-right"></i></button>
            </form>
        </div>

    </div>
    
    <div class="footer-bottom">
        <p>&copy; <%= java.time.Year.now().getValue() %> HairQueen Labs. Tutti i diritti riservati. Progetto Universitario E-Commerce.</p>
    </div>
</footer>