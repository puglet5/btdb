import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"

export default class extends Controller {

  static targets = ["trigger", "tooltip", "arrow"]

  show() {
    this.tooltipTarget.classList.remove("hidden")
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
    this.tooltipTarget.classList.add("hidden")
  }
}
