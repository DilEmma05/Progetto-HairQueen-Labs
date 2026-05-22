package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import it.unisa.hairqueenlabs.dao.OrdineDAO;
import it.unisa.hairqueenlabs.model.Carrello;
import it.unisa.hairqueenlabs.model.DettaglioOrdine;
import it.unisa.hairqueenlabs.model.Ordine;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class ConfermaOrdineServlet
 */
@WebServlet("/ConfermaOrdine")
public class ConfermaOrdineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfermaOrdineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("home");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		// Controlla se l'utente è loggato
		Utente utenteLoggato = (Utente) session.getAttribute("utente");
		if (utenteLoggato == null) {
			request.setAttribute("errore", "La sessione è scaduta o non sei loggato. Effettua l'accesso per completare l'ordine.");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return; 
		}
		
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		if (carrello == null || carrello.getElementi().isEmpty()) {
			response.sendRedirect("carrello");
			return;
		}
		
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String indirizzo = request.getParameter("indirizzo");
		String citta = request.getParameter("citta");
		String cap = request.getParameter("cap");
		String metodoPagamento = request.getParameter("metodoPagamento");

		try {
			Ordine nuovoOrdine = new Ordine();
			nuovoOrdine.setTotale(carrello.getPrezzoTotale()); 
			nuovoOrdine.setStato("In elaborazione");
			nuovoOrdine.setIdUtente(utenteLoggato.getIdUtente()); 
			
			//Trasforma gli elementi del carrello in Dettagli Ordine per il DB
			List<DettaglioOrdine> listaDettagli = new ArrayList<>();
			
			for (Carrello.ElementoCarrello elemento : carrello.getElementi()) {
			    DettaglioOrdine dettaglio = new DettaglioOrdine();
			    dettaglio.setIdProdotto(elemento.getProdotto().getIdProdotto());
			    dettaglio.setQuantitaAcquistata(elemento.getQuantita());
			    dettaglio.setPrezzoUnitario(elemento.getProdotto().getPrezzo());
			    
			    listaDettagli.add(dettaglio);
			}

			// 6. Salvataggio nel Database
			OrdineDAO ordineDAO = new OrdineDAO();
			
			boolean salvataggioOk = ordineDAO.doSaveTransaction(nuovoOrdine, listaDettagli);

			if (salvataggioOk) {
			    session.removeAttribute("carrello");
			    
			    response.setContentType("text/html;charset=UTF-8");
			    response.getWriter().println("<html><body style='background-color: #121212; color: #F5F5F5; font-family: sans-serif; text-align: center; padding-top: 100px;'>");
			    response.getWriter().println("<h1 style='color: #D4AF37;'>Grazie " + nome + "!</h1>");
			    response.getWriter().println("<p style='font-size: 1.2rem;'>Il tuo ordine è stato registrato con successo nel nostro database tramite " + metodoPagamento + ".</p>");
			    response.getWriter().println("<a href='home' style='color: #8E44AD; text-decoration: none; font-weight: bold;'>&larr; Torna alla Home</a>");
			    response.getWriter().println("</body></html>");
			} else {
			    throw new ServletException("Transazione fallita. L'ordine non è stato salvato.");
			}

		} catch (Exception e) {
			throw new ServletException("Errore critico durante il salvataggio dell'ordine.", e);
		}
	}

}