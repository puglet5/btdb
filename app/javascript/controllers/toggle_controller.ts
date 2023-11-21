import { Controller } from "@hotwired/stimulus"
import { Typed } from "stimulus-typescript"

const targets = {
  toggle: HTMLElement,
  svg: HTMLElement
}

export default class extends Typed(Controller, { targets }) {
  toggle() {
    this.toggleTarget.classList.toggle("hidden")
    if (this.svgTarget) {
      this.svgTarget.classList.toggle("rotate-180")
    }
  }
}
