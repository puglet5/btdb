import { Controller } from "@hotwired/stimulus"
import { Typed } from "stimulus-typescript"

const targets = {
  input: HTMLInputElement,
  svg: HTMLElement
}

export default class extends Typed(Controller, { targets }) {



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
