/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"
import "jquery"
import "@client-side-validations/client-side-validations/src"
import "@client-side-validations/simple-form/src"


Turbo.setProgressBarDelay(10)

Turbo.setConfirmMethod(() => {
  let modal = document.getElementById("confirm-modal")
  modal.showModal()

  return new Promise((resolve, reject) => {
    modal.addEventListener("close", () => {
      resolve(modal.returnValue == "confirm")
    }, { once: true })
  })
})

document.addEventListener("turbo:before-visit", e => {
  window.MiniProfilerContainer = document.querySelector("body > .profiler-results")
  if(!e.defaultPrevented) window.MiniProfiler.pageTransition()
})

document.addEventListener("turbo:load", e => {
  if(window.MiniProfilerContainer) {
    document.body.appendChild(window.MiniProfilerContainer)
  }
})
