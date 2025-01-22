// 滚动动画
const featureCards = document.querySelectorAll('.feature-card');

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
}, {
    threshold: 0.5
});

featureCards.forEach(card => {
    observer.observe(card);
});

// 鼠标跟随效果
document.addEventListener('mousemove', (e) => {
    const x = e.clientX / window.innerWidth;
    const y = e.clientY / window.innerHeight;
    
    document.documentElement.style.setProperty('--mouse-x', x);
    document.documentElement.style.setProperty('--mouse-y', y);
});

// 动态背景效果
const hero = document.querySelector('.hero');
hero.addEventListener('mousemove', (e) => {
    const { offsetWidth: width, offsetHeight: height } = hero;
    const { offsetX: x, offsetY: y } = e;
    
    const xWalk = (x / width * 50) - 25;
    const yWalk = (y / height * 50) - 25;
    
    hero.style.setProperty('--x', `${xWalk}px`);
    hero.style.setProperty('--y', `${yWalk}px`);
});