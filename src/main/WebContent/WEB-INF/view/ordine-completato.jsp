<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordine Completato - HairQueen Labs</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<div class="area-pubblica">
    
    <jsp:include page="header.jsp" />

    <main class="container-conferma-ordine">
        <i class="fas fa-check-circle icona-successo"></i>
        
        <h1 class="titolo-conferma">
            Grazie, <%= request.getAttribute("nome") %>!
        </h1>
        
        <p class="testo-conferma">
            Il tuo ordine è stato registrato con successo nel nostro database. Hai scelto di pagare tramite <strong><%= request.getAttribute("metodoPagamento") %></strong>.
        </p>
        
        <a href="<%= request.getContextPath() %>/home" class="btn-hero">&larr; Torna al Catalogo</a>
    </main>

    <jsp:include page="footer.jsp" />

</div>

</body>
</html>