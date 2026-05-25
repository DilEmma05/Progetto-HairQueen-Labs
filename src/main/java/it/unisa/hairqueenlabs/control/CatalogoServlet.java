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
 * Servlet implementation class CatalogoServlet
 */
@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CatalogoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProdottoDAO prodottoDAO = new ProdottoDAO();
		CategoriaDAO categoriaDAO = new CategoriaDAO();
		
		try {
			List<Prodotto> tuttoIlCatalogo = prodottoDAO.doRetrieveAll();
			request.setAttribute("listaProdotti", tuttoIlCatalogo);

			List<Categoria> categorie = categoriaDAO.doRetrieveAllCategorie(); 
			request.setAttribute("listaCategorie", categorie);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			dispatcher.forward(request, response);
			
		} catch(SQLException e) {
			System.out.println("Errore nel recupero di tutti i prodotti dalla CatalogoServlet");
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel database");
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