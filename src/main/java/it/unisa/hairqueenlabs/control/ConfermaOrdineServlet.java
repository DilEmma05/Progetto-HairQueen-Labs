package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class ConfermaOrdineServlet
 */
@WebServlet("/ConfermaOrdine")
public class ConfermaOrdineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfermaOrdineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("home");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String cap = request.getParameter("cap");
        String metodoPagamento = request.getParameter("metodoPagamento");

        // svuota il carrello per simulare l'acquisto andato a buon fine
        session.removeAttribute("carrello");

        //risposta visiva temporanea di successo
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<html><body style='background-color: #121212; color: #F5F5F5; font-family: sans-serif; text-align: center; padding-top: 100px;'>");
        response.getWriter().println("<h1 style='color: #D4AF37;'>Grazie " + nome + "!</h1>");
        response.getWriter().println("<p style='font-size: 1.2rem;'>Il tuo ordine è stato registrato con successo tramite " + metodoPagamento + ".</p>");
        response.getWriter().println("<a href='home' style='color: #8E44AD; text-decoration: none; font-weight: bold;'>&larr; Torna alla Home</a>");
        response.getWriter().println("</body></html>");
	}

}