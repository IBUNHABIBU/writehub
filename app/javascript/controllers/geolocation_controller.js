import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Stimulus");
    this.updateCoordinates();

  }

  updateCoordinates() {
    if (navigator.geolocation) {
      // code goes here
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  }

  handleSuccess(position) {
  }

  
}