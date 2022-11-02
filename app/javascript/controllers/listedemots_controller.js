import { Controller } from "stimulus"
import { startCounter, stopCounter } from '../customs/counter';

export default class extends Controller {
  static targets = [ "answer", "form", "word", "wordInput", "validatedWords", "wordsCounter" ]
  counter_id

  connect() {
    console.log("Hello from counter-controller.js!");
    this.counter_id = startCounter(this.data.get("duration", this.handleEndOfGame.bind(this)));
    // this.counter_id = startCounter(20, this.handleEndOfGame.bind(this));
  }

  handleEndOfGame() {
    stopCounter(this.counter_id);
    this.formTarget.submit();
  }

  gotResponse(event) {
    this.clearWordField();
    const [data, status, xhr] = event.detail;
    const json_response = JSON.parse(xhr.response)
    this.answerTarget.innerHTML = json_response["words"];
    this.validatedWordsTarget.value = json_response["words"]
    this.validationAnimation(json_response["validation"])
  }

  validationAnimation(status) {
    const parent = this.wordInputTarget;
    const animation = document.createElement("div");
    parent.insertBefore(animation, this.wordTarget);
    if (status == "validated") {
      animation.classList.add("valid-animation");
      animation.innerHTML = "+1";
      setTimeout(() => {
        this.incrementValidWords(1);
        animation.remove();
      }, 1000);
    } else {
      animation.classList.add("unvalid-animation");
      animation.innerHTML = "0";
      setTimeout(() => {
        this.incrementValidWords(0);
        animation.remove();
      }, 1000);
    }
  }

  incrementValidWords(inc) {
    this.wordsCounterTarget.innerHTML = parseInt(this.wordsCounterTarget.innerHTML) + inc;
  }

  clearWordField() {
    this.wordTarget.value = "";
    this.wordTarget.focus();
  }

  disconnect() {
    stopCounter(this.counter_id);
  }
}
