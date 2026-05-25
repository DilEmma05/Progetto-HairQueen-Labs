<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Accedi - HairQueen Labs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-auth">

    <header>
        <a href="home"><h1>HAIRQUEEN LABS</h1></a>
    </header>

    <main class="container-login">
        <h2>Accedi al tuo account</h2>

        <% 
            // Recuperiamo ENTRAMBI i parametri una sola volta
            String errore = (String) request.getAttribute("errore");
            String successo = (String) request.getAttribute("successo");
            
            // Se c'è un errore, stampiamo il blocco rosso
            if (errore != null) { 
        %>
            <div class="messaggio-errore">
                <%= errore %>
            </div>
        <% 
            } 
            
            // Se c'è un successo, stampiamo il blocco verde (ora con classe CSS pulita)
            if (successo != null) { 
        %>
            <div class="messaggio-successo">
                <%= successo %>
            </div>
        <% 
            } 
        %>

        <form action="login" method="POST">
            <div class="gruppo-form">
                <label for="email">Indirizzo Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="gruppo-form">
    			<label for="password">Password *</label>
    			<div style="position: relative;">
        			<input type="password" id="password" name="password" required style="padding-right: 40px;">
        			<i id="togglePassword" class="fas fa-eye" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); cursor: pointer; font-size: 1.1rem; color: #bbb; user-select: none; transition: 0.3s;"></i>
    			</div>
			</div>

            <button type="submit" class="btn-login">Accedi</button>
        </form>

        <div class="link-registrazione">
            Non hai ancora un account? <br><br>
            <a href="registrazione.jsp">Crea un account</a>
        </div>
    </main>
    
</div> <script src="js/login.js"></script>

</body>
</html>