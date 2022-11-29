import { Controller } from "stimulus"
import { startCounter, stopCounter } from '../customs/counter';

export default class extends Controller {
  static targets = [ "answer", "form" ]

  connect() {
    console.log("Hello from lecture-yeux-controller.js!");
    // this.counter_id = startCounter(20, this.submitForm.bind(this));
    this.expressionIndex = 1;
    this.expressions = this.formTarget.getElementsByClassName("expression");
    this.expressionsLength = this.expressions.length;
    this.duration = this.data.get("duration") / this.expressionsLength
    this.showExpression(this.expressionIndex);
  }

  handleEndOfGame() {
    this.validationAnswer("no answer")
    this.nextExpression();
  }

  updateProgressBar(inc) {
    let width = inc;
    let element = document.getElementById("progressBar");
    let interval = setInterval(function () {
      if (width >= 100) {
        clearInterval(interval);
      } else {
        width += inc;
        element.style.width = width + '%';
      }
    }
    , this.duration * 10 / 2);
    return interval
  }

  validationExpression(event) {
    this.validationAnswer(event.target.innerHTML);
    this.nextExpression();
  }

  nextExpression() {
    stopCounter(this.counter_id);
    clearInterval(this.progress_id);
    this.hideExpression(this.expressionIndex)
    console.log(this.answerTarget.innerHTML)
    this.expressionIndex += 1;
    if (this.expressionIndex > this.expressionsLength) {
      this.formTarget.submit();
    } else {
      this.showExpression(this.expressionIndex)
    }
  }

  validationAnswer(content) {
    console.log(content)
    this.answerTarget.innerHTML += content + ";"
  }

  hideExpression(index){
    this.expressions[index-1].classList.remove("active");
  }

  showExpression(index){
    this.expressions[index-1].classList.add("active");
    this.counter_id = startCounter(this.duration, this.handleEndOfGame.bind(this));
    this.progress_id = this.updateProgressBar(0.5);
  }

  disconnect() {
    stopCounter(this.counter_id);
  }
}
