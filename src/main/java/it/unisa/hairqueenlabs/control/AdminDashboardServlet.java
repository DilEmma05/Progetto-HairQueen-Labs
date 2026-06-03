package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import it.unisa.hairqueenlabs.dao.OrdineDAO;
import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.model.Ordine;
import it.unisa.hairqueenlabs.model.Prodotto;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class AdminDashboardServlet
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equals(utenteLoggato.getRuolo())) {
            response.sendRedirect("home");
            return;
        }

        try {
            OrdineDAO ordineDAO = new OrdineDAO();
            List<Ordine> tuttiOrdini = ordineDAO.doRetrieveAll();
            request.setAttribute("ordini", tuttiOrdini);

            ProdottoDAO prodottoDAO = new ProdottoDAO();
            List<Prodotto> catalogo = prodottoDAO.doRetrieveAll();
            request.setAttribute("catalogo", catalogo);

            request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Errore durante il caricamento della dashboard amministratore", e);
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