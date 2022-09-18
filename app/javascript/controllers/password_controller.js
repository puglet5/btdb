import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["input"]

  toggle() {
    const input = this.inputTarget

    input.type = input.type === "password" ? "text" : "password"
  }
}
