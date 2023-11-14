import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["input", "svg"]

  connect() {
    if (!this.inputTarget.value) {
      this.svgTarget.parentElement.classList.remove("hidden")
    } else {
      this.svgTarget.parentElement.classList.add("hidden")
    }
  }

  checkEmpty() {
    if (!this.inputTarget.value) {
      this.svgTarget.parentElement.classList.remove("hidden")
    } else {
      this.svgTarget.parentElement.classList.add("hidden")
    }
  }
}
