const togglePassword = document.getElementById('togglePassword');
const pwdInput = document.getElementById('password');

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