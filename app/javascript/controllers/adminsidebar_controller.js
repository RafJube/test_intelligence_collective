import { Controller } from "stimulus"

export default class extends Controller {
  static values = {path: String}

  connect() {
    const element = document.getElementById(this.pathValue)
     if (element) {element.classList.add("active")}
  }
}
