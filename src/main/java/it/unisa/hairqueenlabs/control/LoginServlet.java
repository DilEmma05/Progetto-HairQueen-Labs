package it.unisa.hairqueenlabs.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import it.unisa.hairqueenlabs.dao.UtenteDAO;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Mostra la pagina di login
        RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String passwordCriptata = it.unisa.hairqueenlabs.utils.PasswordUtils.hashPassword(password);

        UtenteDAO utenteDAO = new UtenteDAO();

        try {
            Utente utente = utenteDAO.doRetrieveByEmailAndPassword(email, passwordCriptata);

            if (utente != null) {
                // Login effettuato con successo: salva l'utente in sessione
                HttpSession session = request.getSession();
                session.setAttribute("utente", utente);
                
                // Reindirizziamo alla home
                response.sendRedirect("home");
            } else {
                // Credenziali errate: rimandiamo alla pagina di login con un errore
                request.setAttribute("errore", "Email o password non validi.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Errore durante il login", e);
        }
	}

}