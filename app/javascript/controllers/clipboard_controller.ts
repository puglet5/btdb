import { Controller } from "@hotwired/stimulus"
import { Typed } from "stimulus-typescript"
const targets = {
  text: HTMLAnchorElement,
  svg: HTMLElement
}
export default class extends Typed(Controller, { targets }) {

  async copy() {
    await navigator.clipboard.writeText(this.textTarget.href)
    this.blink()
    this.message()
  }

  blink() {
    const svg = this.svgTarget
    svg.classList.remove("text-gray-400")
    svg.classList.add("text-lime-600")
    setTimeout(function () {
      svg.classList.remove("text-lime-600")
      svg.classList.add("text-gray-400")
    }, 500)
  }

  message() {
    const flash = document.querySelector("#clipboard-flash")
    flash.classList.remove("hidden")
    setTimeout(function () {
      flash.classList.add("hidden")
    }, 2000)
  }
}
