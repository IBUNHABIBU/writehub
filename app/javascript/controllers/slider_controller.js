import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "dot" ]
    static values = { index: Number }

    connect() {
        this.showSlide()
        this.startAutoSlide()
        console.log("Slider connected")
    }

    disconnect() {
        this.stopAutoSlide()
    }

    startAutoSlide() {
        this.interval = setInterval(() => {
            this.nextSlide()
        }, 3000)
    }

    stopAutoSlide() {
        clearInterval(this.interval)
    }

    showSlide() {
        const sliders = this.element.querySelectorAll('.slider__bg');
        let i = 0;
    
        setInterval(() => {
          sliders.forEach((slider, index) => {
            slider.style.display = 'none';
            if (index === i % sliders.length) {
              slider.style.display = 'block';
            }
          });
          i++;
        }, 10000);
    }

    nextSlide() {
        let nextIndex = (this.indexValue + 1) % this.dotTargets.length;
        this.showSlide(nextIndex);
    }

    gotoSlide(event) {
       const index = parseInt(event.target.dataset.index);
       this.showSlide(index);
       this.stopAutoSlide();
       this.startAutoSlide();
    }
}