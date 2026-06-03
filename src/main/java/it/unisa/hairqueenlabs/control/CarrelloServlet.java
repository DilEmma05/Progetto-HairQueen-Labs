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
        
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        String idString = request.getParameter("idProdotto");
        if (idString != null && !idString.isEmpty()) {
            try {
                int idProdotto = Integer.parseInt(idString);
                ProdottoDAO dao = new ProdottoDAO();
                Prodotto prodotto = dao.doRetrieveById(idProdotto);
                
                if (prodotto != null) {
                    carrello.aggiungiProdotto(prodotto);
                }
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
            }
        }
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            int totaleArticoli = carrello.getNumeroTotaleArticoli();
            
            String jsonResponse = "{\"status\": \"success\", \"totaleArticoli\": " + totaleArticoli + "}";

            response.getWriter().write(jsonResponse);
            return;
        }

        response.sendRedirect("carrello");
	}
	
}