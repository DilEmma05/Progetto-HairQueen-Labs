document.addEventListener("DOMContentLoaded", function() {

    const formsCarrello = document.querySelectorAll(".form-ajax-carrello");

    formsCarrello.forEach(function(form) {
        form.addEventListener("submit", function(event) {
            event.preventDefault();

            const btnSubmit = this.querySelector("button[type='submit']");
            const testoOriginale = btnSubmit.innerHTML; 
            const idProdotto = this.querySelector("input[name='idProdotto']").value;

            const xhr = new XMLHttpRequest();

            const actionUrl = this.getAttribute("action"); 
            xhr.open("POST", actionUrl, true);
            
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    const jsonResponse = JSON.parse(xhr.responseText);
                    
                    if (jsonResponse.status === "success") {
                        const badge = document.getElementById("cart-badge");
                        if (badge) {
                            badge.innerText = jsonResponse.totaleArticoli;
                        }

                        btnSubmit.innerHTML = "✔ Aggiunto";
                        btnSubmit.style.backgroundColor = "#27ae60"; 
                        btnSubmit.style.color = "white";
                        btnSubmit.disabled = true; 

                        setTimeout(function() {
                            btnSubmit.innerHTML = testoOriginale;
                            btnSubmit.style.backgroundColor = ""; 
                            btnSubmit.style.color = "";
                            btnSubmit.disabled = false; 
                        }, 2000);
                    }
                }
            };

            xhr.send("idProdotto=" + idProdotto);
        });
    });
});