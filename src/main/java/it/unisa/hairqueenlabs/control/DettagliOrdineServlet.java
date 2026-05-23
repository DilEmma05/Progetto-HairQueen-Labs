package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import it.unisa.hairqueenlabs.dao.OrdineDAO;
import it.unisa.hairqueenlabs.model.DettaglioOrdine;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class DettagliOrdineServlet
 */
@WebServlet("/dettagli-ordine")
public class DettagliOrdineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettagliOrdineServlet() {
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
            response.sendRedirect("login");
            return;
        }
        
        String idOrdineStr = request.getParameter("id");
        if (idOrdineStr != null) {
            try {
                int idOrdine = Integer.parseInt(idOrdineStr);
                OrdineDAO dao = new OrdineDAO();
                
                List<DettaglioOrdine> dettagli = dao.doRetrieveDettagli(idOrdine, utenteLoggato.getIdUtente());

                if (dettagli.isEmpty()) {
                    response.sendRedirect("profilo");
                    return;
                }

                request.setAttribute("dettagli", dettagli);
                request.setAttribute("idOrdine", idOrdine);
                request.getRequestDispatcher("/dettagli-ordine.jsp").forward(request, response);

            } catch (Exception e) {
                throw new ServletException("Errore nel caricamento dei dettagli", e);
            }
        } else {
            response.sendRedirect("profilo");
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
