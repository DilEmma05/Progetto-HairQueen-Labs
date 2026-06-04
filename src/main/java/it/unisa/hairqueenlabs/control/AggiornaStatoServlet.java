package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import it.unisa.hairqueenlabs.dao.OrdineDAO;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class AggiornaStatoServlet
 */
@WebServlet("/aggiorna-stato")
public class AggiornaStatoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiornaStatoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equalsIgnoreCase(utenteLoggato.getRuolo())) {
            response.sendRedirect("home");
            return;
        }

        String idOrdineStr = request.getParameter("idOrdine");
        String nuovoStato = request.getParameter("nuovoStato");

        if (idOrdineStr != null && nuovoStato != null) {
            try {
                int idOrdine = Integer.parseInt(idOrdineStr);
                OrdineDAO ordineDAO = new OrdineDAO();

                ordineDAO.doUpdateStato(idOrdine, nuovoStato);

            } catch (NumberFormatException | SQLException e) {
                throw new ServletException("Errore durante l'aggiornamento dello stato dell'ordine", e);
            }
        }
        
        response.sendRedirect("admin-dashboard");
	}

}