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

/**
 * Servlet implementation class VisualizzaCarrelloServlet
 */
@WebServlet("/carrello")
public class VisualizzaCarrelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VisualizzaCarrelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        
        // Recupera il carrello. Se non esiste, ne crea uno vuoto.
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("/WEB-INF/view/carrello", carrello);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/carrello.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}