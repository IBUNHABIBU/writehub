// app/javascript/controllers/geolocation_controller.js

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button"];

  updateCoordinates() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        this.handleSuccess.bind(this),
        this.handleError.bind(this)
      );
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  }

  handleSuccess(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;

    // Send the coordinates to the server using Turbo Streams
    this.element.outerHTML = `<div data-controller="geolocation" data-geolocation-latitude="${latitude}" data-geolocation-longitude="${longitude}">
                                <button data-action="click->geolocation#updateCoordinates">Update Coordinates</button>
                              </div>`;

    this.stimulate("geolocation#updateCoordinates", { latitude, longitude });
  }

  handleError(error) {
    console.error("Error getting user's location:", error);
  }
}
