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
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class EliminaProdottoServlet
 */
@WebServlet("/EliminaProdottoServlet")
public class EliminaProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaProdottoServlet() {
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
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equalsIgnoreCase(utenteLoggato.getRuolo())) {
            response.sendRedirect("login");
            return;
        }

        String idProdottoStr = request.getParameter("idProdotto");

        if (idProdottoStr != null && !idProdottoStr.isEmpty()) {
            try {
                int idProdotto = Integer.parseInt(idProdottoStr);
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                
                prodottoDAO.doDelete(idProdotto);
                
            } catch (NumberFormatException | SQLException e) {
                System.out.println("Errore durante l'eliminazione del prodotto.");
                e.printStackTrace();
            }
        }

        response.sendRedirect("admin-dashboard?successo=prodottoEliminato");
	}

}