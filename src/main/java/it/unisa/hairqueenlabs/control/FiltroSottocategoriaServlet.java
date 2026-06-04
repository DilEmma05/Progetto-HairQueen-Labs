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
 * Servlet implementation class FiltroSottocategoriaServlet
 */
@WebServlet("/FiltroSottocategoriaServlet")
public class FiltroSottocategoriaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FiltroSottocategoriaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. Recuperiamo l'id della sottocategoria passato dall'URL (es. ?id=1)
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            try {
                int idSottocategoria = Integer.parseInt(idParam);
                
                //Recupero solo i prodotti di questa specifica sottocategoria
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                List<Prodotto> prodottiFiltrati = prodottoDAO.doRetrieveBySottocategoria(idSottocategoria);
                request.setAttribute("listaProdotti", prodottiFiltrati);

                CategoriaDAO categoriaDAO = new CategoriaDAO();
                List<Categoria> categorie = categoriaDAO.doRetrieveAllCategorie();
                request.setAttribute("listaCategorie", categorie);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/catalogo.jsp");
                dispatcher.forward(request, response);
                
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel filtraggio delle sottocategorie.");
            }
        } else {
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