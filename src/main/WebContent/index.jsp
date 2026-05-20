<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.hairqueenlabs.model.Prodotto" %>
<%@ page import="it.unisa.hairqueenlabs.model.Categoria" %>
<%@ page import="it.unisa.hairqueenlabs.dao.CategoriaDAO" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HairQueen Labs</title>
    
    <style>
        /* 1. VARIABILI CSS*/
        :root {
            --sfondo-principale: #121212;
            --testo-principale: #F5F5F5;
            --colore-primario: #8E44AD; /* Viola Ametista */
            --colore-accento: #D4AF37;   /* Oro Luxury */
            --sfondo-card: #1E1E1E;
        }

        /* Stile Globale */
        body {
            background-color: var(--sfondo-principale);
            color: var(--testo-principale);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Header e Logo */
        header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid #2C2C2C;
        }
        header h1 {
            color: var(--colore-accento);
            margin: 0;
            font-size: 2.5rem;
            letter-spacing: 2px;
        }

        /* 2. BARRA CATEGORIE*/
        nav {
            background-color: #1a1a1a;
            padding: 10px 0;
        }
        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex; /* Flexbox per allineamento orizzontale */
            justify-content: center;
            gap: 30px;
        }
        nav ul li a {
            color: var(--testo-principale);
            text-decoration: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            transition: color 0.3s ease; /* Transizione fluida dalle slide */
        }
        /* Pseudo-classe :hover dalle tue slide */
        nav ul li a:hover {
            color: var(--colore-primario);
        }

        /* 3. GRIGLIA PRODOTTI (CSS Grid avanzata) */
        .contenitore-prodotti {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            /* Crea una griglia responsive automatica senza rompersi sui telefoni */
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        /* Card Singolo Prodotto */
        .card-prodotto {
            background-color: var(--sfondo-card);
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            border: 1px solid #2C2C2C;
            transition: transform 0.3s ease, border-color 0.3s ease;
        }
        .card-prodotto:hover {
            transform: translateY(-5px); /* Effetto sollevamento */
            border-color: var(--colore-primario);
        }

        .card-prodotto img {
            max-width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
        }

        .card-prodotto h3 {
            margin: 15px 0 10px 0;
            font-size: 1.2rem;
        }

        .card-prodotto .prezzo {
            color: var(--colore-accento);
            font-size: 1.3rem;
            font-weight: bold;
            margin: 10px 0;
        }

        /* Bottone Call to Action */
        .btn-acquista {
            background-color: var(--colore-accento);
            color: var(--sfondo-principale);
            border: none;
            padding: 10px 20px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            text-transform: uppercase;
            font-size: 0.85rem;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        .btn-acquista:hover {
            background-color: #bfa030; /* Oro leggermente più scuro */
        }
        
        /* --- STILE DROPDOWN MENU --- */
		nav ul li {
    		position: relative; /* Necessario per posizionare il sottomenu */
		}

		/* Il sottomenu (nascosto di base) */
		.dropdown-content {
    		display: none;
    		position: absolute;
    		background-color: #1a1a1a;
    		min-width: 200px;
    		box-shadow: 0px 8px 16px rgba(0,0,0,0.5);
    		z-index: 100;
    		border-top: 2px solid var(--colore-primario); /* Riga viola in alto */
    		padding: 10px 0;
    		text-align: left;
		}

		/* Link dentro il sottomenu */
		.dropdown-content a {
    		padding: 12px 20px;
    		display: block;
    		font-size: 0.8rem;
    		color: var(--testo-principale);
    		text-transform: capitalize;
		}

		.dropdown-content a:hover {
    		background-color: #2c2c2c;
    		color: var(--colore-accento); /* Testo oro al passaggio */
		}

		/* MOSTRA IL MENU AL PASSAGGIO DEL MOUSE */
		nav ul li:hover .dropdown-content {
    		display: block;
		}
        
    </style>
</head>
<body>

    <header>
        <h1>HAIRQUEEN LABS</h1>
        <p>Benvenuti nel tempio della cura dei tuoi capelli</p>
    </header>

    <nav>
        <ul>
        <li><a href="home">Tutti i Prodotti</a></li>
        
        <%
            // 1. Recuperiamo le macro-categorie
            List<Categoria> macroCategorie = (List<Categoria>) request.getAttribute("listaCategorie");
            it.unisa.hairqueenlabs.dao.CategoriaDAO catDAO = new CategoriaDAO();

            if (macroCategorie != null) {
                for (Categoria cat : macroCategorie) {
        %>
                    <li>
                        <a href="FiltroCatalogoServlet?id=<%= cat.getIdCategoria() %>">
                            <%= cat.getNomeCategoria() %> <i class="fa fa-caret-down"></i>
                        </a>

                        <div class="dropdown-content">
                            <%
                                // Per ogni macro-categoria, cerchiamo le sue sottocategorie nel DB
                                List<it.unisa.hairqueenlabs.model.Sottocategoria> sottoCats = 
                                    catDAO.doRetrieveSottocategorie(cat.getIdCategoria());
                                
                                if (sottoCats != null) {
                                    for (it.unisa.hairqueenlabs.model.Sottocategoria s : sottoCats) {
                            %>
                                        <a href="FiltroSottocategoriaServlet?id=<%= s.getIdSottocategoria() %>">
                                            <%= s.getNomeSottocategoria() %>
                                        </a>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </li>
        <%
                }
            }
        %>
        <li><a href="routine">Trova Routine ✨</a></li>
    </ul>
    </nav>

    <main class="contenitore-prodotti">
        <%
            // Recuperiamo la lista inserita nello zainetto dalla HomeServlet
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("listaProdotti");
            
            // Protezione di sicurezza: se qualcuno visita index.jsp direttamente senza passare dalla Servlet
            if (prodotti != null && !prodotti.isEmpty()) {
                // Ciclo Java che genera l'HTML dinamicamente per ogni shampoo nel DB
                for (Prodotto p : prodotti) {
        %>
                    <div class="card-prodotto">
            
            		<% 
                		String urlImmagine = (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) 
                                     		? p.getImmagineUrl() 
                                     		: "https://via.placeholder.com/250x200/1e1e1e/ffffff?text=HairQueen+Product";
                
                		// 2. Aggiungiamo la barra iniziale se manca
                		if(!urlImmagine.startsWith("/") && !urlImmagine.startsWith("http")) {
                    		urlImmagine = "/" + urlImmagine; 
                		}
            		%>
            
            		<a href="prodotto?id=<%= p.getIdProdotto() %>" style="display: block;">
    				<img src="<%= urlImmagine.startsWith("http") ? urlImmagine : request.getContextPath() + urlImmagine %>" alt="<%= p.getNome() %>" style="max-width: 100%; transition: transform 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
					</a>
            
            		<h3>
    					<a href="prodotto?id=<%= p.getIdProdotto() %>" style="color: inherit; text-decoration: none; transition: color 0.3s ease;" onmouseover="this.style.color='var(--colore-primario)'" onmouseout="this.style.color='inherit'">
        				<%= p.getNome() %>
    					</a>
					</h3>
            		<p class="prezzo"><%= String.format("%.2f", p.getPrezzo()) %> &euro;</p>
            		<form action="CarrelloServlet" method="POST" style="margin-top: 15px;">
    				<input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
    				<button type="submit" class="btn-acquista">Aggiungi al Carrello</button>
					</form>
        		</div>
        <%
                }
            } else {
        %>
                <p style="grid-column: 1/-1; text-align: center; color: #888;">
                    Nessun prodotto disponibile nel catalogo. Assicurati di avviare il sito tramite l'URL della Servlet (/home)!
                </p>
        <%
            }
        %>
    </main>

</body>
</html>