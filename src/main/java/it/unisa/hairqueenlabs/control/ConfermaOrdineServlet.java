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

        Utente utenteLoggato = (Utente) session.getAttribute("utente");
        if (utenteLoggato == null) {
            request.setAttribute("errore", "La sessione è scaduta o non sei loggato. Effettua l'accesso per completare l'ordine.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return; 
        }
        
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null || carrello.getElementi().isEmpty()) {
            response.sendRedirect("carrello");
            return;
        }
        
        String nome = request.getParameter("nome");
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

            OrdineDAO ordineDAO = new OrdineDAO();
            boolean salvataggioOk = ordineDAO.doSaveTransaction(nuovoOrdine, listaDettagli);

            if (salvataggioOk) {
                session.removeAttribute("carrello");

                request.setAttribute("nome", nome);
                request.setAttribute("metodoPagamento", metodoPagamento);
                request.getRequestDispatcher("/WEB-INF/view/ordine-completato.jsp").forward(request, response);
                
            } else {
                throw new ServletException("Transazione fallita. L'ordine non è stato salvato.");
            }

        } catch (Exception e) {
            throw new ServletException("Errore critico durante il salvataggio dell'ordine.", e);
        }
	}

}