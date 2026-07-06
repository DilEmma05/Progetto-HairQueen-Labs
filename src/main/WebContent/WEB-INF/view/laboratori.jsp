<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>I Nostri Laboratori - HairQueen Labs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/style.css">
</head>
<body>

<div class="area-pubblica">

    <jsp:include page="header.jsp" />

    <div class="banner-catalogo">
        <h2 class="banner-titolo">I Nostri Laboratori</h2>
        <p class="banner-sottotitolo">Dove la scienza più pura forgia la bellezza della tua corona.</p>
    </div>

    <main class="contenitore-info">
        
        <section class="info-section">
            <h3><i class="fas fa-flask"></i> L'Arte della Formulazione</h3>
            <p>In HairQueen Labs non creiamo semplici prodotti per capelli, ma veri e propri elisir studiati a livello molecolare. I nostri ricercatori selezionano rigorosamente i principi attivi più puri, bilanciando estratti botanici rari con biotecnologie di ultima generazione.</p>
            <p>Ogni shampoo, maschera o siero che lascia i nostri laboratori è stato sottoposto a mesi di test clinici (rigorosamente cruelty-free) per garantire un ripristino profondo della fibra capillare, agendo direttamente sulla porosità e sull'idratazione della cute.</p>
        </section>

        <section class="info-section">
            <h3><i class="fas fa-microchip"></i> Ingegneria del Calore</h3>
            <p>I nostri strumenti di styling nascono da una sfida ingegneristica: asciugare e modellare il capello annullando i danni da calore estremo. I phon e le piastre HairQueen Labs sono dotati di microprocessori intelligenti che misurano la temperatura dell'aria fino a 40 volte al secondo.</p>
            <p>Questo controllo termico assoluto preserva la naturale lucentezza del capello, proteggendo la cheratina e garantendo risultati da salone professionale comodamente a casa tua.</p>
        </section>

        <section class="info-section">
            <h3><i class="fas fa-leaf"></i> Lusso Sostenibile</h3>
            <p>Crediamo che il vero lusso debba rispettare il mondo in cui viviamo. L'energia utilizzata nei nostri poli di ricerca proviene al 100% da fonti rinnovabili. Inoltre, il packaging della nostra linea care è realizzato in materiali riciclati e completamente riciclabili, formulato per mantenere inalterata la stabilità termica dei nostri composti senza gravare sull'ambiente.</p>
        </section>

    </main>

    <jsp:include page="footer.jsp" />

</div>

</body>
</html>