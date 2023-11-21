import { Controller } from "@hotwired/stimulus"
import { Typed } from "stimulus-typescript"

const targets = {
  element: HTMLElement
}

export default class extends Typed(Controller, { targets }) {


  connect() {
  }

  hide() {
    this.elementTarget.classList.add("hidden")
  }

}
