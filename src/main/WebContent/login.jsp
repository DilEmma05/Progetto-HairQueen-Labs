<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Accedi - HairQueen Labs</title>
    <style>
        :root {
            --sfondo-principale: #121212;
            --testo-principale: #F5F5F5;
            --colore-primario: #8E44AD; 
            --colore-accento: #D4AF37;   
            --sfondo-card: #1E1E1E;
            --colore-errore: #e74c3c;
        }

        body {
            background-color: var(--sfondo-principale);
            color: var(--testo-principale);
            font-family: 'Segoe UI', sans-serif;
            margin: 0; padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header { text-align: center; padding: 20px 0; border-bottom: 1px solid #2C2C2C; }
        header h1 { color: var(--colore-accento); margin: 0; letter-spacing: 2px; }
        header a { text-decoration: none; }

        .container-login {
            max-width: 450px;
            margin: 60px auto;
            background-color: var(--sfondo-card);
            padding: 40px;
            border-radius: 8px;
            border: 1px solid #2C2C2C;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
        }

        h2 { text-align: center; color: var(--testo-principale); border-bottom: 2px solid var(--colore-primario); padding-bottom: 10px; margin-top: 0; margin-bottom: 30px;}

        .gruppo-form { margin-bottom: 25px; }
        .gruppo-form label { display: block; margin-bottom: 8px; color: #bbb; font-size: 0.9rem; }
        .gruppo-form input {
            width: 100%; padding: 12px; border: 1px solid #333; background-color: #121212;
            color: white; border-radius: 4px; box-sizing: border-box; font-size: 1rem;
            transition: border-color 0.3s;
        }
        .gruppo-form input:focus { border-color: var(--colore-accento); outline: none; }

        .btn-login {
            width: 100%; background-color: var(--colore-accento); color: var(--sfondo-principale);
            border: none; padding: 15px; font-size: 1.1rem; font-weight: bold; border-radius: 4px;
            cursor: pointer; text-transform: uppercase; transition: 0.3s; margin-top: 10px;
        }
        .btn-login:hover { background-color: #bfa030; }

        .messaggio-errore {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--colore-errore);
            padding: 10px;
            border: 1px solid var(--colore-errore);
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9rem;
        }

        .link-registrazione { text-align: center; margin-top: 25px; font-size: 0.95rem; color: #bbb; }
        .link-registrazione a { color: var(--colore-primario); text-decoration: none; font-weight: bold; }
        .link-registrazione a:hover { color: #a55eea; text-decoration: underline; }
    </style>
</head>
<body>

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
            
            // Se c'è un successo, stampiamo il blocco verde
            if (successo != null) { 
        %>
            <div style="background-color: rgba(46, 204, 113, 0.1); color: #2ecc71; padding: 10px; border: 1px solid #2ecc71; border-radius: 4px; margin-bottom: 20px; text-align: center; font-size: 0.9rem; font-weight: bold;">
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
    
    <script>
    const togglePassword = document.getElementById('togglePassword');
    const pwdInput = document.getElementById('password');

    togglePassword.addEventListener('click', function () {
        // Controlla il tipo attuale: se è password diventa text, altrimenti torna password
        const type = pwdInput.getAttribute('type') === 'password' ? 'text' : 'password';
        pwdInput.setAttribute('type', type);
        
        // Cambia l'icona (usa un'emoji diversa o un occhio sbarrato quando nascosta)
        this.textContent = type === 'password' ? '👁️' : '🙈';
    });
    </script>

</body>
</html>