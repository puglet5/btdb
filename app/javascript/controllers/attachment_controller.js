import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["delete", "object", "return", "div", "input"]

  static values = {
    classname: String,
    id: String
  }

  greyout() {
    this.objectTarget.classList.toggle("opacity-25")
  }

  delete() {
    this.greyout()
    this.deleteTarget.classList.toggle("hidden")
    this.returnTarget.classList.toggle("hidden")

    let input = document.createElement("input")
    input.classList.add("hidden")
    input.name = `${this.classnameValue}[purge_attachments][]`
    input.setAttribute("value", this.idValue)
    input.setAttribute("data-attachment-target", "input")
    this.divTarget.appendChild(input)

    console.log(this.classnameValue)
  }

  return() {
    this.greyout()
    this.deleteTarget.classList.toggle("hidden")
    this.returnTarget.classList.toggle("hidden")

    this.inputTarget.remove()
  }
}
