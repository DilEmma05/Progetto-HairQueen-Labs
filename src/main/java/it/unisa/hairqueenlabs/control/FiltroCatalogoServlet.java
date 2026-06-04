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

import it.unisa.hairqueenlabs.dao.CategoriaDAO;
import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.model.Categoria;
import it.unisa.hairqueenlabs.model.Prodotto;

/**
 * Servlet implementation class FiltroCatalogoServlet
 */
@WebServlet("/FiltroCatalogoServlet")
public class FiltroCatalogoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FiltroCatalogoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. Recuperiamo l'id della categoria passato dall'URL (es. FiltroCatalogoServlet?id=1)
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            try {
                int idCategoria = Integer.parseInt(idParam);
                
                //recupero i prodotti filtrati
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                List<Prodotto> prodottiFiltrati = prodottoDAO.doRetrieveByCategoria(idCategoria);
                
                request.setAttribute("listaProdotti", prodottiFiltrati);
                
                //Ricarichiamo la lista delle macro-categorie per non far sparire la barra del menu
                CategoriaDAO categoriaDAO = new CategoriaDAO();
                List<Categoria> categorie = categoriaDAO.doRetrieveAllCategorie();
                request.setAttribute("listaCategorie", categorie);
                
                // 4. Inoltriamo la richiesta alla index.jsp che si occuperà di stampare tutto
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/catalogo.jsp");
                dispatcher.forward(request, response);
                
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel filtraggio dei prodotti.");
            }
        } else {
            // Se l'utente prova ad accedere alla servlet senza parametri, lo rimandiamo alla home
            response.sendRedirect("home");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
