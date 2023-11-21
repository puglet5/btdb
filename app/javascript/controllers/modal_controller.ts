import { Controller } from "@hotwired/stimulus"
import { Typed } from "stimulus-typescript"

const targets = {
  modal: HTMLElement
}

export default class extends Typed(Controller, { targets }) {

  static targets = ["modal"]

  toggle() {
    this.modalTarget.classList.toggle("hidden")
  }
}
