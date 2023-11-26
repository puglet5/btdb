import { Application } from "@hotwired/stimulus"

declare global {
  interface Window {
    stimulus: Application
  }
}

const application = Application.start()

application.debug = false
window.stimulus = application

export { application }
