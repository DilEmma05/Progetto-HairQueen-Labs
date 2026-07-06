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

        if (utenteLoggato == null || !"ADMIN".equalsIgnoreCase(utenteLoggato.getRuolo())) {
            response.sendRedirect("home");
            return;
        }

        try {
            OrdineDAO ordineDAO = new OrdineDAO();
            List<Ordine> ordini;
            
            String mostraOrdini = request.getParameter("mostraOrdini");
            if ("tutti".equals(mostraOrdini)) {
                ordini = ordineDAO.doRetrieveAll();
                request.setAttribute("scopeOrdini", "tutti");
            } else {
                ordini = ordineDAO.doRetrieveByUtente(utenteLoggato.getIdUtente());
                request.setAttribute("scopeOrdini", "miei");
            }
            request.setAttribute("ordini", ordini);

            ProdottoDAO prodottoDAO = new ProdottoDAO();
            List<Prodotto> catalogo;
            String mostra = request.getParameter("mostra");
            
            if ("tutti".equals(mostra)) {
                catalogo = prodottoDAO.doRetrieveAllAdmin();
                request.setAttribute("scopeVisualizzazione", "tutti");
            } else {
                catalogo = prodottoDAO.doRetrieveByAdmin(utenteLoggato.getIdUtente());
                request.setAttribute("scopeVisualizzazione", "miei");
            }
            request.setAttribute("catalogo", catalogo);
            
            request.getRequestDispatcher("/WEB-INF/view/admin-dashboard.jsp").forward(request, response);

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