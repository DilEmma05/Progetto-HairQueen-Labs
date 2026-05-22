package it.unisa.hairqueenlabs.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import it.unisa.hairqueenlabs.model.Carrello;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
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
			request.setAttribute("errore", "Per procedere al checkout devi prima accedere o registrarti.");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return; 
		}
		
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		if (carrello == null || carrello.getElementi().isEmpty()) {
			response.sendRedirect("carrello");
			return;
		}
		request.getRequestDispatcher("/checkout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}