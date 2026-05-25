<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Crea Account - HairQueen Labs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="area-auth">

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
                <label for="telefono">Numero di Cellulare *</label>
                <input type="tel" id="telefono" name="telefono" required>
                <div id="errore-telefono" class="messaggio-errore-js">Inserisci un numero valido di 10 cifre.</div>
            </div>

            <div class="gruppo-form">
                <label for="password">Password *</label>
                <div style="position: relative;">
        			<input type="password" id="password" name="password" required style="padding-right: 40px;">
        			<i id="togglePassword" class="fas fa-eye" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); cursor: pointer; font-size: 1.1rem; color: #bbb; user-select: none; transition: 0.3s;"></i>
    			</div>
                <div id="errore-password" class="messaggio-errore-js">La password deve contenere almeno 8 caratteri, una lettera MAIUSCOLA, un numero e un carattere speciale.</div>
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

</div> <script src="js/registrazione.js"></script>
</body>
</html>