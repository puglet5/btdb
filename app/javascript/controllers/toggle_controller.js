import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "svg"]

  toggle() {
    this.toggleTarget.classList.toggle("hidden")
    this.svgTarget.classList.toggle("rotate-180")
  }
}
