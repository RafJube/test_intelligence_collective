import { Controller } from "stimulus"
import { startCounter, stopCounter } from '../customs/counter';

export default class extends Controller {
  static targets = [ "answer", "button", "form" ]

  connect() {
    console.log("Hello from nasa-controller.js!");
    this.counter_id = startCounter(this.data.get("duration", this.handleEndOfGame.bind(this)));
    // this.counter_id = startCounter(20, this.submitForm.bind(this));
  }

  handleEndOfGame() {
    stopCounter(this.counter_id);
    this.formTarget.submit();
  }

  submitForm(event) {
    event.preventDefault();
    const inputs = this.element.getElementsByTagName("li");
    let answer = "";
    for (const input of inputs) {
      answer += `${input.innerText}/`;
    }
    this.answerTarget.innerText = answer;
    if (confirm("Voulez-vous soumettre le résultats?")) {
      this.formTarget.submit();
    } else {
      return false;
    }
  }

  disconnect() {
    stopCounter(this.counter_id);
  }
}
