// Recuperiamo tutti gli elementi necessari dal DOM
const track = document.querySelector('.carousel-track');
const slides = Array.from(track.children);
const nextButton = document.querySelector('.carousel-button-right');
const prevButton = document.querySelector('.carousel-button-left');
const dotsNav = document.querySelector('.carousel-nav');
const dots = Array.from(dotsNav.children);

// Funzione universale per spostare la visibilità di una slide
const moveToSlide = (track, currentSlide, targetSlide) => {
    currentSlide.classList.remove('current-slide');
    targetSlide.classList.add('current-slide');
}

// Aggiorna l'aspetto dei "pallini" indicatori in basso
const updateDots = (currentDot, targetDot) => {
    currentDot.classList.remove('current-slide');
    targetDot.classList.add('current-slide');
}

// Nasconde le freccette se siamo all'inizio o alla fine dello slider
const hideShowArrows = (slides, prevButton, nextButton, targetIndex) => {
    if (targetIndex === 0) {
        prevButton.classList.add('is-hidden');
        nextButton.classList.remove('is-hidden');
    } else if (targetIndex === slides.length - 1) {
        prevButton.classList.remove('is-hidden');
        nextButton.classList.add('is-hidden');
    } else {
        prevButton.classList.remove('is-hidden');
        nextButton.classList.remove('is-hidden');
    }
}

//GESTIONE DEGLI EVENTI

//Click su bottone DESTRO (Slide successiva)
nextButton.addEventListener('click', e => {
    const currentSlide = track.querySelector('.current-slide');
    const nextSlide = currentSlide.nextElementSibling;
    const currentDot = dotsNav.querySelector('.current-slide');
    const nextDot = currentDot.nextElementSibling;
    const nextIndex = slides.findIndex(slide => slide === nextSlide);
    
    moveToSlide(track, currentSlide, nextSlide);
    updateDots(currentDot, nextDot);
    hideShowArrows(slides, prevButton, nextButton, nextIndex);
});

//Click su bottone SINISTRO (Slide precedente)
prevButton.addEventListener('click', e => {
    const currentSlide = track.querySelector('.current-slide');
    const prevSlide = currentSlide.previousElementSibling;
    const currentDot = dotsNav.querySelector('.current-slide');
    const prevDot = currentDot.previousElementSibling;
    const prevIndex = slides.findIndex(slide => slide === prevSlide);
    
    moveToSlide(track, currentSlide, prevSlide);
    updateDots(currentDot, prevDot);
    hideShowArrows(slides, prevButton, nextButton, prevIndex);
});

//Click sui "PALLINI" indicatori
dotsNav.addEventListener('click', e => {
    const targetDot = e.target.closest('button');
    if (!targetDot) return;
    
    const currentSlide = track.querySelector('.current-slide');
    const currentDot = dotsNav.querySelector('.current-slide');
    const targetIndex = dots.findIndex(dot => dot === targetDot);
    const targetSlide = slides[targetIndex];
    
    moveToSlide(track, currentSlide, targetSlide);
    updateDots(currentDot, targetDot);
    hideShowArrows(slides, prevButton, nextButton, targetIndex);
});

//AUTOPLAY CAROUSEL

const TEMPO_AUTOPLAY = 5000;
let intervalloAutoplay;

function scorriAutomaticamente() {
    const currentSlide = track.querySelector('.current-slide');
    const currentIndex = slides.findIndex(slide => slide === currentSlide);

    if (currentIndex === slides.length - 1) {
        dots[0].click();
    } else {
        nextButton.click();
    }
}

// Accende il metronomo
function avviaAutoplay() {
    intervalloAutoplay = setInterval(scorriAutomaticamente, TEMPO_AUTOPLAY);
}

// Azzera il metronomo
function resettaAutoplay(e) {
    if (e && e.isTrusted) {
        clearInterval(intervalloAutoplay); 
        avviaAutoplay();                   
    }
}
avviaAutoplay();

nextButton.addEventListener('click', resettaAutoplay);
prevButton.addEventListener('click', resettaAutoplay);
dotsNav.addEventListener('click', resettaAutoplay);