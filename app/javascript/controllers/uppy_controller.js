import { Controller } from "@hotwired/stimulus"
import Uppy from "@uppy/core"
import Dashboard from "@uppy/dashboard"
import ActiveStorageUpload from "uppy-activestorage-upload"

export default class extends Controller {

  static targets = ["div", "trigger", "text", "avatar", "avatardiv", "avatarPlaceholder"]

  static values = {
    filetype: String,
    allowedfiletypes: String,
    allowmultiple: Boolean,
    thumbnails: Boolean
  }

  connect() {

    const setupUppy = (element) => {
      let trigger = this.triggerTarget

      let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
      let field_name = element.dataset.uppy

      trigger.addEventListener("click", (e) => e.preventDefault())

      let uppy = new Uppy({
        autoProceed: false,
        allowMultipleUploads: this.allowmultipleValue,
        allowMultipleUploadBatches: this.allowmultipleValue,
        restrictions: {
          allowedFileTypes: this.allowedfiletypesValue ? [this.allowedfiletypesValue] : null,
          maxNumberOfFiles: this.allowmultipleValue ? null : 1
        },
      })

      uppy.use(ActiveStorageUpload, {
        directUploadUrl: direct_upload_url
      })

      uppy.use(Dashboard, {
        disableThumbnailGenerator: !this.thumbnailsValue,
        trigger: trigger,
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
        if (this.hasTextTarget) {
          const txt = this.textTarget
          txt.innerHTML = `${files_uploaded} ${this.filetypeValue} uploaded`
        }
        result.successful.forEach(file => {
          appendUploadedFile(element, file, field_name)
          if (this.hasAvatardivTarget) {
            previewAvatar(element, file)
          }
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

    const previewAvatar = (element, file) => {
      if (this.hasAvatarTarget) {
        this.avatarTarget.src = file.preview
      }
      else {
        const avatarDiv = this.avatardivTarget
        let avatar = document.createElement("img")
        avatar.src = file.preview
        const cls = ["object-cover", "rounded-full", "w-20", "h-20", "md:w-40", "md:h-40"]
        avatar.classList.add(...cls)
        this.avatarPlaceholderTarget.remove()
        avatarDiv.prepend(avatar)
      }
    }

    setupUppy(this.divTarget)
  }
}
