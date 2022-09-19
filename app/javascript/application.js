// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"
import "jquery"
import "@client-side-validations/client-side-validations/src"
import "@client-side-validations/simple-form/src"

// eslint-disable-next-line no-undef
Turbo.setConfirmMethod(() => {
  let modal = document.getElementById("confirm-modal")
  modal.showModal()

  console.log(modal)

  // eslint-disable-next-line no-unused-vars
  return new Promise((resolve, reject) => {
    modal.addEventListener("close", () => {
      resolve(modal.returnValue == "confirm")
    }, { once: true })
  })
})
