import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Stimulus");
    this.updateCoordinates();

  }

  updateCoordinates() {
    if (navigator.geolocation) {
      console.log(navigator.geolocation.getCurrentPosition, 'Current position');
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  }

  handleSuccess(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    // Send the coordinates to the server using Turbo Streams
    this.stimulate("geolocation#updateCoordinates", { latitude, longitude });
  }

  handleError(error) {
    console.error("Error getting user's location:", error);
  }
}