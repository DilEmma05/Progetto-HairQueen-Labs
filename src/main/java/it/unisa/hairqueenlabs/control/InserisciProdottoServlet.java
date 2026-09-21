package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;

import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.model.Prodotto;
import it.unisa.hairqueenlabs.model.Utente;

/**
 * Servlet implementation class InserisciProdottoServlet
 */
@WebServlet("/inserisci-prodotto")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  
    maxFileSize = 1024 * 1024 * 10,       
    maxRequestSize = 1024 * 1024 * 50     
)
public class InserisciProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InserisciProdottoServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null || !"ADMIN".equalsIgnoreCase(utenteLoggato.getRuolo())) {
            response.sendRedirect("home");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/inserisci-prodotto.jsp").forward(request, response);
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
        String faseUtilizzo = request.getParameter("faseUtilizzo");
        String idSottocategoriaStr = request.getParameter("idSottocategoria");
        String tipoCuteTarget = request.getParameter("tipoCuteTarget");
        String tipoCapelloTarget = request.getParameter("tipoCapelloTarget");

        Part filePart = request.getPart("immagineFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String immagineUrl = "";

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            filePart.write(uploadPath + File.separator + fileName);
            
            immagineUrl = "images/" + fileName;
        }

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
            nuovoProdotto.setIdUtente(utenteLoggato.getIdUtente());

            String isNovitaStr = request.getParameter("isNovita");
            nuovoProdotto.setNovita(isNovitaStr != null && isNovitaStr.equals("true"));
            
            String isAttivoStr = request.getParameter("is_attivo");
            nuovoProdotto.setAttivo(isAttivoStr != null);

            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodottoDAO.doSave(nuovoProdotto);

            response.sendRedirect("admin-dashboard?successo=prodottoInserito");

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Errore durante l'inserimento del nuovo prodotto", e);
        }
    }

}