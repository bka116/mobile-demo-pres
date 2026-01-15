let currentSlide = 0;
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;
const counterEl = document.getElementById('counter');
const progressEl = document.getElementById('progress');

function updateSlide() {
    slides.forEach((slide, index) => {
        slide.classList.remove('active');
        if (index === currentSlide) {
            slide.classList.add('active');
        }
    });

    // Format counter with leading zero
    const current = (currentSlide + 1).toString().padStart(2, '0');
    const total = totalSlides.toString().padStart(2, '0');
    counterEl.textContent = `${current} / ${total}`;

    // Update progress bar
    const progress = ((currentSlide + 1) / totalSlides) * 100;
    progressEl.style.width = `${progress}%`;
}

function nextSlide() {
    if (currentSlide < totalSlides - 1) {
        currentSlide++;
        updateSlide();
    }
}

function prevSlide() {
    if (currentSlide > 0) {
        currentSlide--;
        updateSlide();
    }
}

// Keyboard Navigation
document.addEventListener('keydown', (e) => {
    if (e.code === 'ArrowRight' || e.code === 'Space' || e.code === 'Enter') {
        nextSlide();
    } else if (e.code === 'ArrowLeft') {
        prevSlide();
    }
});

// Click Navigation (Left/Right side of screen)
document.body.addEventListener('click', (e) => {
    // Ignore clicks on buttons or inside the phone mockup (for realism feeling)
    if (e.target.closest('button') || e.target.closest('.phone-mockup')) return;

    const width = window.innerWidth;
    if (e.clientX > width / 2) {
        nextSlide();
    } else {
        prevSlide();
    }
});

// Initial setup
updateSlide();


