import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="humburger"
export default class extends Controller {
  static targets = ["nav"];

  connect() {
    this.toggleNav();
    this.closeNav();
  }

  toggleNav() {
    const humburger = this.element.querySelector(".humburger");
    const nav = this.navTarget;
    humburger.classList.toggle("active");
    nav.classList.toggle("nav-mobile");  // Assuming "show" class makes the nav visible
    // Optionally add logic to close the nav when clicking on any item in the nav
  }

  closeNav() {
    const humburger = this.element.querySelector(".humburger");
    const nav = this.navTarget;

    humburger.classList.remove("active");
    nav.classList.remove("nav-mobile");  // Hide the nav

    // Optionally, you can also prevent any links from firing while the nav closes
    // event.stopPropagation();
  }
}