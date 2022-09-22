import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["validate"]

  connect() {
    console.log("hit")
    this.validateTarget.hidden = true
  }

  submit() {
    this.validateTarget.click()
  }

}
