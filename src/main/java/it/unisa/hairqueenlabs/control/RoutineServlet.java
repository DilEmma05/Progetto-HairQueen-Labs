package it.unisa.hairqueenlabs.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import it.unisa.hairqueenlabs.dao.ProdottoDAO;
import it.unisa.hairqueenlabs.model.Prodotto;

/**
 * Servlet implementation class RoutineServlet
 */
@WebServlet("/routine")
public class RoutineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoutineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("routine.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cute = request.getParameter("cute");
        String capello = request.getParameter("capello");

        String nomeRoutine = "Il tuo Rituale Personalizzato";
        String descrizioneRoutine = "Una combinazione esclusiva formulata nei nostri laboratori, progettata specificamente per equilibrare la cute " + cute + " e valorizzare i capelli " + capello + ".";

        List<Prodotto> prodottiConsigliati = null;

        try {
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodottiConsigliati = prodottoDAO.doRetrieveRaccomandati(cute, capello); 
            
        } catch (Exception e) {
            System.out.println("Errore durante la generazione della routine");
            e.printStackTrace();
        }

        request.setAttribute("prodottiConsigliati", prodottiConsigliati);
        request.setAttribute("nomeRoutine", nomeRoutine);
        request.setAttribute("descrizioneRoutine", descrizioneRoutine);

        request.getRequestDispatcher("routine.jsp").forward(request, response);
	}

}