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

@WebServlet("/ApplicaFiltriServlet")
public class ApplicaFiltriServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String[] cuteTarget = request.getParameterValues("cute");
        String[] capelloTarget = request.getParameterValues("capello");
        String fasciaPrezzo = request.getParameter("prezzo");
        String ordinamento = request.getParameter("sort");

        request.setAttribute("cuteSelezionate", (cuteTarget != null) ? java.util.Arrays.asList(cuteTarget) : new java.util.ArrayList<String>());
        request.setAttribute("capelloSelezionate", (capelloTarget != null) ? java.util.Arrays.asList(capelloTarget) : new java.util.ArrayList<String>());
        request.setAttribute("prezzoSelezionato", (fasciaPrezzo != null) ? fasciaPrezzo : "tutti");
        request.setAttribute("ordinamentoSelezionato", (ordinamento != null) ? ordinamento : "default");

        try {
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            List<Prodotto> risultati;

            boolean nessunFiltroCute = (cuteTarget == null || cuteTarget.length == 0);
            boolean nessunFiltroCapello = (capelloTarget == null || capelloTarget.length == 0);
            boolean nessunFiltroPrezzo = (fasciaPrezzo == null || fasciaPrezzo.equals("tutti"));
            boolean nessunOrdinamento = (ordinamento == null || ordinamento.equals("default"));

            if (nessunFiltroCute && nessunFiltroCapello && nessunFiltroPrezzo && nessunOrdinamento) {
                risultati = prodottoDAO.doRetrieveAll(); 
                request.setAttribute("titoloPagina", "La Nostra Collezione");
            } else {
                risultati = prodottoDAO.doRetrieveByFilters(cuteTarget, capelloTarget, fasciaPrezzo, ordinamento);
                request.setAttribute("titoloPagina", "Risultati Filtri");
            }

            request.setAttribute("listaProdotti", risultati);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/catalogo.jsp"); 
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home"); 
        }
    }
}