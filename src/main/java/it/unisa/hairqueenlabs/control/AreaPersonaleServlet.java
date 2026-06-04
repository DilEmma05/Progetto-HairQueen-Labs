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
import it.unisa.hairqueenlabs.model.Ordine;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class AreaPersonaleServlet
 */
@WebServlet("/profilo")
public class AreaPersonaleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AreaPersonaleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

        Utente utenteLoggato = (Utente) session.getAttribute("utente");
        if (utenteLoggato == null) {
            request.setAttribute("errore", "Devi accedere per visualizzare la tua area personale.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        try {
            OrdineDAO ordineDAO = new OrdineDAO();
            List<Ordine> listaOrdini = ordineDAO.doRetrieveByUtente(utenteLoggato.getIdUtente());

            request.setAttribute("ordini", listaOrdini);

            request.getRequestDispatcher("/WEB-INF/view/profilo.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Errore durante il recupero dello storico ordini", e);
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