import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "dot" ]
    static values = { index: Number }

    connect() {
        this.showSlide(0)
        this.startAutoSlide()
    }

    disconnect() {
        this.stopAutoSlide()
    }

    startAutoSlide() {
        this.interval = setInterval(() => {
            this.next()
        }, 3000)
    }

}