import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
  }

  switch(e) {

    const active = this.tabTargets.filter(elem => elem.classList.contains("active-tab") )[0]
    const current = e.target.parentElement

    if (current !== active) {

      this.tabTargets.forEach((tab, index) => {

        if (tab === active) {

          tab.classList.remove("active-tab")
          this.panelTargets[index].classList.add("hidden")

        } else if (tab === current) {

          current.classList.add("active-tab")
          this.panelTargets[index].classList.remove("hidden")

        }
      })

    }
  }
}
