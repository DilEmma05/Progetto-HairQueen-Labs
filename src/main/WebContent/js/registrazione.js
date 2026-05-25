const form = document.getElementById('form-registrazione');
const emailInput = document.getElementById('email');
const emailError = document.getElementById('errore-email');

const pwdInput = document.getElementById('password');
const pwdError = document.getElementById('errore-password');
const togglePassword = document.getElementById('togglePassword');

const telInput = document.getElementById('telefono');
const telError = document.getElementById('errore-telefono');

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
const telRegex = /^\d{10}$/; 

function validaCampo(input, errorDiv, regex) {
    if (!regex.test(input.value)) {
        input.classList.add('input-errore');
        errorDiv.style.display = 'block';
        return false;
    } else {
        input.classList.remove('input-errore');
        errorDiv.style.display = 'none';
        return true;
    }
}

emailInput.addEventListener('input', () => validaCampo(emailInput, emailError, emailRegex));
pwdInput.addEventListener('input', () => validaCampo(pwdInput, pwdError, pwdRegex));
telInput.addEventListener('input', () => validaCampo(telInput, telError, telRegex));

togglePassword.addEventListener('click', function () {
    const type = pwdInput.getAttribute('type') === 'password' ? 'text' : 'password';
    pwdInput.setAttribute('type', type);
    
    if (type === 'password') {
        this.classList.remove('fa-eye-slash');
        this.classList.add('fa-eye');
        this.style.color = '#bbb'; 
    } else {
        this.classList.remove('fa-eye');
        this.classList.add('fa-eye-slash');
        this.style.color = 'var(--colore-accento)'; 
    }
});

form.addEventListener('submit', function(event) {
    let isFormValid = this.checkValidity(); 
    let isEmailValid = validaCampo(emailInput, emailError, emailRegex);
    let isPwdValid = validaCampo(pwdInput, pwdError, pwdRegex);
    let isTelValid = validaCampo(telInput, telError, telRegex);
    
    const inputs = this.querySelectorAll('input[required]');
    inputs.forEach(input => {
        if (!input.value) {
            input.classList.add('input-errore');
            isFormValid = false;
        } else if (input !== emailInput && input !== pwdInput && input !== telInput) {
            input.classList.remove('input-errore');
        }
    });

    if (!isFormValid || !isEmailValid || !isPwdValid || !isTelValid) {
        event.preventDefault(); 
    }
});