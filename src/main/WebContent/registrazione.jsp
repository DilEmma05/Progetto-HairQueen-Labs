<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crea Account - HairQueen Labs</title>
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

        .container-registrazione {
            max-width: 600px;
            margin: 40px auto;
            background-color: var(--sfondo-card);
            padding: 40px;
            border-radius: 8px;
            border: 1px solid #2C2C2C;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
        }

        h2 { text-align: center; color: var(--testo-principale); border-bottom: 2px solid var(--colore-primario); padding-bottom: 10px; margin-top: 0; margin-bottom: 30px;}

        .riga-doppia { display: flex; gap: 20px; }
        .riga-doppia .gruppo-form { flex: 1; }

        .gruppo-form { margin-bottom: 20px; position: relative; }
        .gruppo-form label { display: block; margin-bottom: 8px; color: #bbb; font-size: 0.9rem; }
        
        .gruppo-form input {
            width: 100%; padding: 12px; border: 1px solid #333; background-color: #121212;
            color: white; border-radius: 4px; box-sizing: border-box; font-size: 1rem;
            transition: border-color 0.3s;
        }
        .gruppo-form input:focus { border-color: var(--colore-accento); outline: none; }

        /* Stili attivati dal JavaScript in caso di errore */
        .input-errore { border-color: var(--colore-errore) !important; background-color: rgba(231, 76, 60, 0.05) !important; }
        .messaggio-errore-js { color: var(--colore-errore); font-size: 0.85rem; margin-top: 5px; display: none; font-weight: bold; }

        .btn-registrati {
            width: 100%; background-color: var(--colore-accento); color: var(--sfondo-principale);
            border: none; padding: 15px; font-size: 1.1rem; font-weight: bold; border-radius: 4px;
            cursor: pointer; text-transform: uppercase; transition: 0.3s; margin-top: 10px;
        }
        .btn-registrati:hover { background-color: #bfa030; }

        .link-login { text-align: center; margin-top: 25px; font-size: 0.95rem; color: #bbb; }
        .link-login a { color: var(--colore-primario); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

    <header>
        <a href="home"><h1>HAIRQUEEN LABS</h1></a>
    </header>

    <main class="container-registrazione">
        <h2>Unisciti a HairQueen</h2>

        <form action="registrazione" method="POST" id="form-registrazione" novalidate>
            <div class="riga-doppia">
                <div class="gruppo-form">
                    <label for="nome">Nome *</label>
                    <input type="text" id="nome" name="nome" required>
                </div>
                <div class="gruppo-form">
                    <label for="cognome">Cognome *</label>
                    <input type="text" id="cognome" name="cognome" required>
                </div>
            </div>

            <div class="gruppo-form">
                <label for="email">Indirizzo Email *</label>
                <input type="email" id="email" name="email" required>
                <div id="errore-email" class="messaggio-errore-js">Inserisci un'email valida (es. nome@dominio.it)</div>
            </div>

            <div class="gruppo-form">
                <label for="password">Password *</label>
                <input type="password" id="password" name="password" required>
                <div id="errore-password" class="messaggio-errore-js">La password deve contenere almeno 8 caratteri, una lettera e un numero.</div>
            </div>

            <div class="gruppo-form">
                <label for="indirizzo">Indirizzo Completo *</label>
                <input type="text" id="indirizzo" name="indirizzo" required>
            </div>

            <button type="submit" class="btn-registrati">Crea Account</button>
        </form>

        <div class="link-login">
            Hai già un account? <a href="login">Accedi qui</a>
        </div>
    </main>

    <script>
        document.getElementById('form-registrazione').addEventListener('submit', function(event) {
            let isValid = true;
            
            // 1. Constraint Validation API generica per i campi vuoti
            if (!this.checkValidity()) {
                isValid = false;
            }

            // 2. RegExp Validation per l'Email
            const emailInput = document.getElementById('email');
            const emailError = document.getElementById('errore-email');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailRegex.test(emailInput.value)) {
                emailInput.classList.add('input-errore');
                emailError.style.display = 'block';
                isValid = false;
            } else {
                emailInput.classList.remove('input-errore');
                emailError.style.display = 'none';
            }

            // 3. RegExp Validation per la Password
            // Deve contenere almeno 8 caratteri, di cui almeno 1 lettera e 1 numero
            const pwdInput = document.getElementById('password');
            const pwdError = document.getElementById('errore-password');
            const pwdRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

            if (!pwdRegex.test(pwdInput.value)) {
                pwdInput.classList.add('input-errore');
                pwdError.style.display = 'block';
                isValid = false;
            } else {
                pwdInput.classList.remove('input-errore');
                pwdError.style.display = 'none';
            }

            // Se ci sono errori, blocco l'invio del form alla Servlet
            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>