// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-hello-target="output"></h1>
// </div>

import { Controller } from "stimulus"
import { counter } from '../customs/counter';

export default class extends Controller {
  static targets = ["time", "button"]

  connect() {
    console.log("Hello from counter-controller.js!");
    counter(this.data.get("duration"));
  }

  disableToSubmit() {
    console.log("Hi")
  }
}
