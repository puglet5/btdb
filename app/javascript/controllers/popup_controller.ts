import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"

export default class extends Controller {

  static targets = ["trigger", "tooltip", "arrow"]

  connect() {
  }

  show() {
    this.tooltipTarget.classList.remove("invisible")
    this.tooltipTarget.classList.add("opacity-100")
    createPopper(this.triggerTarget, this.tooltipTarget, {
      placement: "top",
      modifiers: [
        {
          name: "arrow",
          options: {
            element: this.arrowTarget,
          },
        },
      ],
    })
  }

  hide() {
    this.tooltipTarget.classList.add("invisible")
    this.tooltipTarget.classList.remove("opacity-100")
  }
}
