package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import it.unisa.hairqueenlabs.dao.RecensioneDAO;
import it.unisa.hairqueenlabs.model.Recensione;
import it.unisa.hairqueenlabs.model.Utente;

@WebServlet("/inserisci-recensione")
public class InserisciRecensioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null) {
            response.sendRedirect("login");
            return;
        }

        String idProdottoStr = request.getParameter("idProdotto");
        String votoStr = request.getParameter("voto");
        String testo = request.getParameter("testo");

        try {
            int idProdotto = Integer.parseInt(idProdottoStr);
            int voto = Integer.parseInt(votoStr);

            Recensione nuovaRecensione = new Recensione();
            nuovaRecensione.setVoto(voto);
            nuovaRecensione.setTesto(testo);
            nuovaRecensione.setIdUtente(utenteLoggato.getIdUtente());
            nuovaRecensione.setIdProdotto(idProdotto);

            RecensioneDAO recensioneDAO = new RecensioneDAO();
            recensioneDAO.doSave(nuovaRecensione);

            response.sendRedirect("prodotto?id=" + idProdotto + "&successo=recensioneInserita");

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Errore durante il salvataggio della recensione", e);
        }
    }
}