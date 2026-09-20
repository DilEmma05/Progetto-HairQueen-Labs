document.getElementById('form-checkout').addEventListener('submit', function(event) {
    if (!this.checkValidity()) {
        event.preventDefault(); 
        
        this.classList.add('form-tentato'); 
        
        document.getElementById('messaggio-errore').style.display = 'block'; 
    }
});