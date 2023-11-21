import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"
import { Typed } from "stimulus-typescript"


const targets = {
  trigger: HTMLElement,
  tooltip: HTMLElement,
  arrow: HTMLElement,
}


export default class extends Typed(Controller, { targets }) {
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
    if (this.hasTooltipTarget) {
      this.tooltipTarget.classList.add("hidden")
    }
  }
}
