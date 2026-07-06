const togglePassword = document.getElementById('togglePassword');
const pwdInput = document.getElementById('password');

togglePassword.addEventListener('click', function () {
    // Alterna il tipo dell'input
    const type = pwdInput.getAttribute('type') === 'password' ? 'text' : 'password';
    pwdInput.setAttribute('type', type);
    
    // Alterna le classi di FontAwesome
    if (type === 'password') {
        this.classList.remove('fa-eye-slash');
        this.classList.add('fa-eye');
        this.style.color = '#bbb'; // Colore neutro quando nascosta
    } else {
        this.classList.remove('fa-eye');
        this.classList.add('fa-eye-slash');
        this.style.color = 'var(--colore-accento)'; // Si colora di oro quando visibile
    }
});