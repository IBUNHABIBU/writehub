import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "latitude", "longitude" ]

    connect() {
        console.log("*********** Geolocation Controller ***********");
        if (navigator.geolocation) {
          console.log("Geo location is supported by this browser");
        navigator.geolocation.getCurrentPosition(
            this.handleSuccess.bind(this),
            this.handleError.bind(this)
          );
        } else {
        console.log("Geolocation is not supported by this browser.");
        }
    }

   handleSuccess(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    console.log("*********** Longitude&Latitude ***********");
    console.log(latitude, longitude);
    // Send the coordinates to the server using Turbo Streams
    this.element.outerHTML = `<div data-controller="geolocation" data-geolocation-latitude="${latitude}" data-geolocation-longitude="${longitude}">
                                </div>`;

    this.stimulate("geolocation#updateCoordinates", { latitude, longitude });
   }

   handleError(error) {
    console.error("Error getting user's location:", error);
   }
}