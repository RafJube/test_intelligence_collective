import { Controller } from "stimulus"
import { startCounter, stopCounter } from '../customs/counter';

export default class extends Controller {
  static targets = [ "answer", "form" ]
  counter_id

  connect() {
    console.log("Hello from lecture-yeux-controller.js!");
    this.counter_id = startCounter(this.data.get("duration", this.handleEndOfGame.bind(this)));
    // this.counter_id = startCounter(20, this.submitForm.bind(this));
    this.expressionIndex = 1;
    this.expressions = this.formTarget.getElementsByClassName("expression");
    this.expressionsLength = this.expressions.length;
    this.showExpression(this.expressionIndex);
  }

  handleEndOfGame() {
    stopCounter(this.counter_id);
    this.formTarget.submit();
  }

  nextExpression(event) {
    this.validationAnswer(event.target);
    this.hideExpression(this.expressionIndex)
    console.log(this.answerTarget.innerHTML)
    this.expressionIndex += 1;
    if (this.expressionIndex > this.expressionsLength) {
      this.formTarget.submit();
    } else {
      this.showExpression(this.expressionIndex)
    }
  }

  validationAnswer(target) {
    console.log(target.innerHTML)
    this.answerTarget.innerHTML += target.innerHTML + ";"
  }

  hideExpression(index){
    this.expressions[index-1].classList.remove("active");
  }

  showExpression(index){
    this.expressions[index-1].classList.add("active");
  }

  disconnect() {
    stopCounter(this.counter_id);
  }
}
