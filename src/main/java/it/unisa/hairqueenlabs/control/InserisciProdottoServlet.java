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
 * Servlet implementation class InserisciProdottoServlet
 */
@WebServlet("/inserisci-prodotto")
public class InserisciProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InserisciProdottoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equals(utenteLoggato.getRuolo())) {
            response.sendRedirect("home");
            return;
        }

        request.getRequestDispatcher("/inserisci-prodotto.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equals(utenteLoggato.getRuolo())) {
            response.sendRedirect("home");
            return;
        }

        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        String prezzoStr = request.getParameter("prezzo");
        String quantitaStr = request.getParameter("quantita");
        String immagineUrl = request.getParameter("immagineUrl");
        String faseUtilizzo = request.getParameter("faseUtilizzo");
        String idSottocategoriaStr = request.getParameter("idSottocategoria");
        String tipoCuteTarget = request.getParameter("tipoCuteTarget");
        String tipoCapelloTarget = request.getParameter("tipoCapelloTarget");

        try {
            double prezzo = Double.parseDouble(prezzoStr);
            int quantita = Integer.parseInt(quantitaStr);
            int idSottocategoria = 0;
            if (idSottocategoriaStr != null && !idSottocategoriaStr.isEmpty()) {
                idSottocategoria = Integer.parseInt(idSottocategoriaStr);
            }

            Prodotto nuovoProdotto = new Prodotto();
            nuovoProdotto.setNome(nome);
            nuovoProdotto.setDescrizione(descrizione);
            nuovoProdotto.setPrezzo(prezzo);
            nuovoProdotto.setQuantitaMagazzino(quantita);
            nuovoProdotto.setImmagineUrl(immagineUrl);
            nuovoProdotto.setFaseUtilizzo(faseUtilizzo);
            nuovoProdotto.setIdSottocategoria(idSottocategoria);
            nuovoProdotto.setTipoCuteTarget(tipoCuteTarget);
            nuovoProdotto.setTipoCapelloTarget(tipoCapelloTarget);

            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodottoDAO.doSave(nuovoProdotto);

            //reindirizzamento alla dashboard dopo il successo per evitare reinvii del form
            response.sendRedirect("admin-dashboard?successo=prodottoInserito");

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Errore durante l'inserimento del nuovo prodotto", e);
        }
	}

}
