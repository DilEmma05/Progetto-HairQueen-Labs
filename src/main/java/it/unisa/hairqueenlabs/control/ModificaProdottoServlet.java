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
import it.unisa.hairqueenlabs.model.Prodotto;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class ModificaProdottoServlet
 */
@WebServlet("/modifica-prodotto")
public class ModificaProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaProdottoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equalsIgnoreCase(utenteLoggato.getRuolo())) {
            response.sendRedirect("login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int idProdotto = Integer.parseInt(idStr);
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                Prodotto prodottoDaModificare = prodottoDAO.doRetrieveById(idProdotto);
                
                if (prodottoDaModificare != null) {
                    request.setAttribute("prodotto", prodottoDaModificare);
                    request.getRequestDispatcher("/modifica-prodotto.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin-dashboard");
                }
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("admin-dashboard");
            }
        } else {
            response.sendRedirect("admin-dashboard");
        }
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

        try {
            Prodotto p = new Prodotto();
            p.setIdProdotto(Integer.parseInt(request.getParameter("idProdotto")));
            p.setNome(request.getParameter("nome"));
            p.setDescrizione(request.getParameter("descrizione"));
            p.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
            p.setQuantitaMagazzino(Integer.parseInt(request.getParameter("quantitaMagazzino")));
            p.setImmagineUrl(request.getParameter("immagineUrl"));
            p.setFaseUtilizzo(request.getParameter("faseUtilizzo"));
            
            String idSottoCat = request.getParameter("idSottocategoria");
            p.setIdSottocategoria((idSottoCat != null && !idSottoCat.isEmpty()) ? Integer.parseInt(idSottoCat) : 0);
            
            p.setTipoCuteTarget(request.getParameter("tipoCuteTarget"));
            p.setTipoCapelloTarget(request.getParameter("tipoCapelloTarget"));

            String isNovitaStr = request.getParameter("isNovita");
            p.setNovita(isNovitaStr != null && isNovitaStr.equals("true"));

            ProdottoDAO dao = new ProdottoDAO();
            dao.doUpdate(p);

            response.sendRedirect("admin-dashboard?successo=prodottoModificato");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard?errore=modificaFallita");
        }
	}

}