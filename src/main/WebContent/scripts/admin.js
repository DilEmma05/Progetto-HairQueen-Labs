// Variabile globale per memorizzare quale form inviare
let currentFormId = null; 

// Funzione per aprire la modale
function openDeleteModal(idProdotto, nomeProdotto) {
    currentFormId = 'form-delete-' + idProdotto; 
    document.getElementById('modalProductName').innerText = nomeProdotto; 
    document.getElementById('deleteModal').style.display = 'flex'; 
}

// Funzione per chiudere la modale
function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none'; 
    currentFormId = null;
}

// Associa l'evento al bottone di conferma SOLO quando la pagina è pronta
document.addEventListener("DOMContentLoaded", function() {
    const btnConfirmDelete = document.getElementById('btnConfirmDelete');
    
    if (btnConfirmDelete) {
        btnConfirmDelete.addEventListener('click', function() {
            if (currentFormId) {
                document.getElementById(currentFormId).submit(); 
            }
        });
    }
});