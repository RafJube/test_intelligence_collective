import { Controller } from "stimulus"

export default class extends Controller {

  animation() {
    const elt = this.element
    this.initialise(elt);
    elt.classList.contains("animated") ? elt.classList.remove("animated") : elt.classList.add("animated");
  }

  initialise(elt) {
    const animates = document.getElementsByClassName("animated")
    for (const animate of animates) {
      if (animate != elt) {animate.classList.remove("animated")}
    }
  }
}
