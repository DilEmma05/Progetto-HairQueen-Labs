document.getElementById('form-checkout').addEventListener('submit', function(event) {
    // Controlla se ci sono campi non compilati o non validi
    if (!this.checkValidity()) {
        // Blocca l'invio del form alla Servlet
        event.preventDefault(); 
        
        // Aggiunge la classe che fa diventare rossi i campi vuoti
        this.classList.add('form-tentato'); 
        
        // Mostra il messaggio di errore sotto il bottone
        document.getElementById('messaggio-errore').style.display = 'block'; 
    }
});