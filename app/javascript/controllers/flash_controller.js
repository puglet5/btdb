import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["close", "flash"]

  connect() {
    const flash = this.element
    flash.classList.add("flash")
    setTimeout(function () { flash.classList.add("hidden") }, 3000)
  }

  close() {
    this.flashTarget.remove()
  }
}
