import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.updateCoordinates();
  }

  updateCoordinates() {
    if (navigator.geolocation) {
      // find the latitude and longitude from here
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  }

}