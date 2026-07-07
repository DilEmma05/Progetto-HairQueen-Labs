<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo Prodotti - HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-pubblica">

    <jsp:include page="header.jsp"/>
    
    <%
        String titoloPagina = (String) request.getAttribute("titoloPagina");
        if (titoloPagina == null || titoloPagina.isEmpty()) {
            titoloPagina = "La Nostra Collezione";
        }
    %>

    <div class="banner-catalogo">
        <h2 class="banner-titolo"><%= titoloPagina %></h2>
        <p class="banner-sottotitolo">L'eccellenza HairQueen Labs per la tua routine di bellezza.</p>
    </div>

    <div class="layout-catalogo">
        
        <aside class="sidebar-filtri">
            <form action="<%= request.getContextPath() %>/ApplicaFiltriServlet" method="GET">
                <h3>Filtra e Ordina</h3>
                
                <%
                    List<String> cuteSel = (List<String>) request.getAttribute("cuteSelezionate");
                    List<String> capelloSel = (List<String>) request.getAttribute("capelloSelezionate");
                    String prezzoSel = (String) request.getAttribute("prezzoSelezionato");
                    String ordSel = (String) request.getAttribute("ordinamentoSelezionato");
                    
                    if (cuteSel == null) cuteSel = new java.util.ArrayList<>();
                    if (capelloSel == null) capelloSel = new java.util.ArrayList<>();
                    if (prezzoSel == null) prezzoSel = "tutti";
                    if (ordSel == null) ordSel = "default";
                %>

                <div class="gruppo-filtro">
                    <h4>Ordina per</h4>
                    <select name="sort" style="width: 100%; padding: 10px; border-radius: 4px; background-color: var(--sfondo-principale); color: var(--testo-principale); border: 1px solid rgba(150, 150, 150, 0.3);">
                        <option value="default" <%= ordSel.equals("default") ? "selected" : "" %>>Più Rilevanti</option>
                        <option value="prezzo_asc" <%= ordSel.equals("prezzo_asc") ? "selected" : "" %>>Prezzo: dal più basso</option>
                        <option value="prezzo_desc" <%= ordSel.equals("prezzo_desc") ? "selected" : "" %>>Prezzo: dal più alto</option>
                        <option value="nome_asc" <%= ordSel.equals("nome_asc") ? "selected" : "" %>>Nome: A - Z</option>
                        <option value="nome_desc" <%= ordSel.equals("nome_desc") ? "selected" : "" %>>Nome: Z - A</option>
                    </select>
                </div>

                <div class="gruppo-filtro">
                    <h4>Tipo di Cute</h4>
                    <label><input type="checkbox" name="cute" value="Normale" <%= cuteSel.contains("Normale") ? "checked" : "" %>> Normale</label>
                    <label><input type="checkbox" name="cute" value="Secca/Sensibile" <%= cuteSel.contains("Secca/Sensibile") ? "checked" : "" %>> Secca/Sensibile</label>
                    <label><input type="checkbox" name="cute" value="Grassa" <%= cuteSel.contains("Grassa") ? "checked" : "" %>> Grassa</label>
                    <label><input type="checkbox" name="cute" value="Tutti" <%= cuteSel.contains("Tutti") ? "checked" : "" %>> Tutti</label>
                </div>

                <div class="gruppo-filtro">
                    <h4>Tipo di Capello</h4>
                    <label><input type="checkbox" name="capello" value="Lisci" <%= capelloSel.contains("Lisci") ? "checked" : "" %>> Lisci</label>
                    <label><input type="checkbox" name="capello" value="Mossi/Ricci" <%= capelloSel.contains("Mossi/Ricci") ? "checked" : "" %>> Mossi/Ricci</label>
                    <label><input type="checkbox" name="capello" value="Sottile" <%= capelloSel.contains("Sottile") ? "checked" : "" %>> Sottile</label>
                    <label><input type="checkbox" name="capello" value="Tutti" <%= capelloSel.contains("Tutti") ? "checked" : "" %>> Tutti</label>
                </div>

                <div class="gruppo-filtro">
                    <h4>Prezzo</h4>
                    <label><input type="radio" name="prezzo" value="tutti" <%= prezzoSel.equals("tutti") ? "checked" : "" %>> Qualsiasi prezzo</label>
                    <label><input type="radio" name="prezzo" value="0-15" <%= prezzoSel.equals("0-15") ? "checked" : "" %>> Sotto i 15 &euro;</label>
                    <label><input type="radio" name="prezzo" value="15-30" <%= prezzoSel.equals("15-30") ? "checked" : "" %>> Tra 15 &euro; e 30 &euro;</label>
                    <label><input type="radio" name="prezzo" value="30-50" <%= prezzoSel.equals("30-50") ? "checked" : "" %>> Tra 30 &euro; e 50 &euro;</label>
                    <label><input type="radio" name="prezzo" value="50-9999" <%= prezzoSel.equals("50-9999") ? "checked" : "" %>> Oltre 50 &euro;</label>
                </div>

                <button type="submit" class="btn-applica-filtri">Applica Filtri</button>
            </form>
        </aside>

        <main class="contenitore-prodotti">
            <%
                List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("listaProdotti");
                
                if (prodotti != null && !prodotti.isEmpty()) {
                    for (Prodotto p : prodotti) {
            %>
                        <div class="card-prodotto">
                
                        <% 
                            String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                                ? p.getImmagineUrl() 
                                                : "https://via.placeholder.com/250x200/1e1e1e/ffffff?text=HairQueen+Product";
                    
                            if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) {
                                urlImmagine = "/" + urlImmagine; 
                            }
                        %>
                
                        <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-immagine-prodotto">
                            <img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" class="img-prodotto">
                        </a>
                
                        <h3>
                            <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getIdProdotto() %>" class="link-titolo-prodotto">
                            <%= p.getNome() %>
                            </a>
                        </h3>
                        <p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
                        
                        <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-ajax-carrello">
                            <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                            <button type="submit" class="btn-acquista">Aggiungi al Carrello</button>
                        </form>
                    </div>
            <%
                    }
                } else {
            %>
                    <p class="messaggio-catalogo-vuoto" style="grid-column: 1 / -1; width: 100%;">
                        Nessun prodotto trovato in questa categoria o con i filtri selezionati.
                    </p>
            <%
                }
            %>
        </main>
        
    </div>
    <jsp:include page="footer.jsp" />

</div> 

<script src="<%= request.getContextPath() %>/scripts/ajax-carrello.js"></script>

</body>
</html>