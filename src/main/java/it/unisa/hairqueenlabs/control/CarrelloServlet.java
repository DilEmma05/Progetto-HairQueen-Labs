package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.model.Carrello;
import it.unisa.hairqueenlabs.model.Prodotto;

/**
 * Servlet implementation class CarrelloServlet
 */
@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CarrelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        
		//Recupera il carrello dalla sessione. Se non esiste, ne crea uno nuovo
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		if (carrello == null) {
			carrello = new Carrello();
			session.setAttribute("carrello", carrello);
		}

		//Recupera l'ID del prodotto dal form di dettaglio.jsp
		String idString = request.getParameter("idProdotto");
        
		if (idString != null && !idString.isEmpty()) {
			try {
				int idProdotto = Integer.parseInt(idString);
				ProdottoDAO dao = new ProdottoDAO();
				Prodotto prodotto = dao.doRetrieveById(idProdotto);
                
				if (prodotto != null) {
                   //Aggiunge il prodotto al carrello
					carrello.aggiungiProdotto(prodotto);
				}
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
			}
        }

        //Una volta aggiunto, reindirizza l'utente alla pagina del carrello
        response.sendRedirect("carrello");
	}
	
}