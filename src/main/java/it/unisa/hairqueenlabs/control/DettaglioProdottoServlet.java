package it.unisa.hairqueenlabs.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.dao.RecensioneDAO;
import it.unisa.hairqueenlabs.model.Prodotto;
import it.unisa.hairqueenlabs.model.Recensione;

/**
 * Servlet implementation class DettaglioProdottoServlet
 */
@WebServlet("/prodotto")
public class DettaglioProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioProdottoServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idString = request.getParameter("id");
        
        if (idString != null && !idString.isEmpty()) {
            try {
                int id = Integer.parseInt(idString);
                ProdottoDAO model = new ProdottoDAO();
                Prodotto prodotto = model.doRetrieveById(id);
                
                if (prodotto != null) {
                    // Salva il prodotto nella request per passarlo alla JSP
                    request.setAttribute("prodotto", prodotto);
                    
                    // MODIFICA: Recupera le recensioni del prodotto e le aggiunge alla request
                    RecensioneDAO recensioneDAO = new RecensioneDAO();
                    List<Recensione> listaRecensioni = recensioneDAO.doRetrieveByProdotto(id);
                    request.setAttribute("recensioni", listaRecensioni);
                    
                    // Invia l'utente alla pagina di dettaglio
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/dettaglio.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Se l'ID manca, non è un numero valido, o il prodotto non esiste nel DB, torna alla home
        response.sendRedirect("home");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}