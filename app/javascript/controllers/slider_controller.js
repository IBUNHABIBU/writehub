import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "dot" ]
    static values = { index: Number }

    connect() {
        this.showSlide(0)
        this.startAutoSlide()
        console.log("Slider connected")
    }

    disconnect() {
        this.stopAutoSlide()
    }

    startAutoSlide() {
        this.interval = setInterval(() => {
            this.next()
        }, 3000)
    }

    stopAutoSlide() {
        clearInterval(this.interval)
    }

    showSlide(index) {
        // this.indexValue = index
        // this.dotTargets.forEach((el, i) => {
        //     el.classList.toggle("active", index == i)
        // })
        const slides = this.element.querySelectorAll(".slide");
        slides.forEach((slide, i) => {
            // slide.classList.toggle("active", index == i)
            slide.style.transform = `translateX(${100 * (i - index)}%)`
        });

        this.dotTargets.forEach((dot, i) => {
            dot.classList.toggle("active", index == i)
        });

        this.indexValue = index;
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