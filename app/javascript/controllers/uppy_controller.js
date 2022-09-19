import { Controller } from "@hotwired/stimulus"
import Uppy from "@uppy/core"
import Dashboard from "@uppy/dashboard"
import ActiveStorageUpload from "uppy-activestorage-upload"

export default class extends Controller {

  static targets = ["div", "trigger", "text"]

  static values = {
    filetype: String,
    allowedfiletypes: String
  }

  connect() {

    const setupUppy = (element) => {
      let trigger = this.triggerTarget

      let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
      let field_name = element.dataset.uppy

      trigger.addEventListener("click", (e) => e.preventDefault())

      let uppy = new Uppy({
        autoProceed: false,
        allowMultipleUploads: true,
        allowMultipleUploadBatches: true,
        restrictions: {
          allowedFileTypes: this.allowedfiletypesValue ? [this.allowedfiletypesValue] : null,
        },
      })

      uppy.use(ActiveStorageUpload, {
        directUploadUrl: direct_upload_url
      })

      uppy.use(Dashboard, {
        disableThumbnailGenerator: false,
        trigger: trigger,
        // target: target,
        closeAfterFinish: true,
        inline: false,
        showProgressDetails: true,
        fileManagerSelectionType: "both",
        proudlyDisplayPoweredByUppy: false
      })

      let dashboard = document.querySelector(".uppy-Dashboard-inner")
      dashboard.removeAttribute("style")

      let files_uploaded = 0

      uppy.on("complete", (result) => {
        files_uploaded += result.successful.length
        let txt = this.textTarget
        txt.innerHTML = `${files_uploaded} ${this.filetypeValue} uploaded`
        result.successful.forEach(file => {
          appendUploadedFile(element, file, field_name)
        })
      })
    }

    const appendUploadedFile = (element, file, field_name) => {
      const hiddenField = document.createElement("input")

      hiddenField.setAttribute("type", "hidden")
      hiddenField.setAttribute("name", field_name)
      hiddenField.setAttribute("data-pending-upload", true)
      hiddenField.setAttribute("value", file.response.signed_id)

      element.appendChild(hiddenField)
    }

    setupUppy(this.divTarget)
  }
}
