import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.updateCoordinates();
  }

  updateCoordinates() {
    if (navigator.geolocation) {
      console.log("Geo location is supported by this browser");
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

    console.log("*********** Longitude&Latitude ***********");
    console.log(latitude, longitude);

    this.sendCoordinates(latitude, longitude);
  }

  handleError(error) {
    console.error("Error getting user's location:", error);
  }

  sendCoordinates(latitude, longitude) {
    fetch('/articles/update_coordinates', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ latitude: latitude, longitude: longitude })
    })
    .then(response => response.json())
    .then(data => {
      console.log('Success:', data);
    })
    .catch((error) => {
      console.error('Error:', error);
    });
  }
}
