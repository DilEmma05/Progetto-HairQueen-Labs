package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import it.unisa.hairqueenlabs.dao.OrdineDAO;
import it.unisa.hairqueenlabs.model.DettaglioOrdine;
import it.unisa.hairqueenlabs.model.Utente;

@WebServlet("/scarica-fattura")
public class ScaricaFatturaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("utente");

        if (utenteLoggato == null) {
            response.sendRedirect("login");
            return;
        }

        String idOrdineStr = request.getParameter("id");
        if (idOrdineStr == null) {
            response.sendRedirect("profilo");
            return;
        }

        try {
            int idOrdine = Integer.parseInt(idOrdineStr);
            OrdineDAO dao = new OrdineDAO();
            List<DettaglioOrdine> dettagli = dao.doRetrieveDettagli(idOrdine, utenteLoggato.getIdUtente());

            if (dettagli.isEmpty()) {
                response.sendRedirect("profilo");
                return;
            }
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"Fattura_HairQueen_Ordine_" + idOrdine + ".pdf\"");

            Document document = new Document();
            
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Font fontTitolo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24);
            Font fontSottotitolo = FontFactory.getFont(FontFactory.HELVETICA, 12);
            Font fontIntestazioneTabella = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);

            Paragraph titolo = new Paragraph("HAIRQUEEN LABS", fontTitolo);
            titolo.setAlignment(Element.ALIGN_CENTER);
            document.add(titolo);
            
            Paragraph infoAzienda = new Paragraph("Il tempio della cura dei tuoi capelli\nPartita IVA: 01234567890", fontSottotitolo);
            infoAzienda.setAlignment(Element.ALIGN_CENTER);
            infoAzienda.setSpacingAfter(30f);
            document.add(infoAzienda);

            document.add(new Paragraph("Fattura per Ordine N°: " + idOrdine, fontIntestazioneTabella));
            Paragraph datiCliente = new Paragraph("Cliente: " + utenteLoggato.getNome() + " " + utenteLoggato.getCognome() + "\nEmail: " + utenteLoggato.getEmail());
            datiCliente.setSpacingAfter(20f);
            document.add(datiCliente);

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            
            table.addCell(new PdfPCell(new Phrase("Prodotto", fontIntestazioneTabella)));
            table.addCell(new PdfPCell(new Phrase("Quantità", fontIntestazioneTabella)));
            table.addCell(new PdfPCell(new Phrase("Prezzo Unitario", fontIntestazioneTabella)));
            table.addCell(new PdfPCell(new Phrase("Subtotale", fontIntestazioneTabella)));

            double totaleOrdine = 0;

            for (DettaglioOrdine d : dettagli) {
                table.addCell(d.getNomeProdotto());
                table.addCell(String.valueOf(d.getQuantitaAcquistata()));
                table.addCell(String.format("%.2f €", d.getPrezzoUnitario()));
                
                double subTotale = d.getPrezzoUnitario() * d.getQuantitaAcquistata();
                table.addCell(String.format("%.2f €", subTotale));
                
                totaleOrdine += subTotale;
            }

            document.add(table);

            Paragraph totaleParagrafo = new Paragraph("TOTALE PAGATO: " + String.format("%.2f €", totaleOrdine), fontTitolo);
            totaleParagrafo.setAlignment(Element.ALIGN_RIGHT);
            totaleParagrafo.setSpacingBefore(20f);
            document.add(totaleParagrafo);

            document.close();

        } catch (Exception e) {
            throw new ServletException("Errore durante la generazione del PDF", e);
        }
    }
}