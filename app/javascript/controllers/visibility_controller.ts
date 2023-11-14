import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["element"]

  connect() {
  }

  hide() {
    this.elementTarget.classList.add("hidden")
  }

}
