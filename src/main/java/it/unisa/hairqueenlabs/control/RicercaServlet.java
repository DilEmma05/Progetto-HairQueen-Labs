package it.unisa.hairqueenlabs.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.model.Prodotto;

@WebServlet("/ricerca")
public class RicercaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("q");

        if (query != null && !query.trim().isEmpty()) {
            try {
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                List<Prodotto> risultati = prodottoDAO.doRetrieveByNomeOrDescrizione(query.trim());
                
                request.setAttribute("prodotti", risultati);
                request.setAttribute("queryRicerca", query);
                
            } catch (SQLException e) {
                e.printStackTrace();
                throw new ServletException("Errore durante la ricerca nel database.");
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/risultati-ricerca.jsp");
        dispatcher.forward(request, response);
    }
}