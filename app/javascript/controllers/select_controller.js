import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select/dist/js/tom-select.complete.js"

export default class extends Controller {

  connect() {
    var config = {
      plugins: [],
      persist: false,
    }
    new TomSelect("#select", config)
  }

}
