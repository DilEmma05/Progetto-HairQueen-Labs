let currentFormId = null; 

function openDeleteModal(idProdotto, nomeProdotto) {
    currentFormId = 'form-delete-' + idProdotto; 
    document.getElementById('modalProductName').innerText = nomeProdotto; 
    document.getElementById('deleteModal').style.display = 'flex'; 
}

function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none'; 
    currentFormId = null;
}

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