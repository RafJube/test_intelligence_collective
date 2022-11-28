// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-hello-target="output"></h1>
// </div>

import { Controller } from "stimulus"
import { startStopWatch, stopStopWatch } from '../customs/stop_watch';

export default class extends Controller {
  static values = { gameId: Number, gridSize: Number, ghostsPosition: String }
  static targets = [ "gameGrid", "score", "form", "hitsCount", "totalTime" ]

  connect() {
    console.log("Hello from game-optimisation-controller.js!");
    this.stopWatch_id = startStopWatch();
    this.cells = this.element.getElementsByClassName("grid-cell")
    this.ghostsPosition = Object.values(JSON.parse(this.ghostsPositionValue))
    this.startPosition = 1;
    this.gridSize = this.gridSizeValue
    this.arrivalPosition = this.gridSize * this.gridSize
    this.scoreTarget.innerHTML = 0
    this.startTime = new Date().getTime();
    this.elementsPlacing()
    console.log(this.totalTimeTarget.value)
  }

  endGame() {
    console.log("Gagné!!!")
    stopStopWatch(this.stopWatch_id)
    this.hitsCountTarget.value = this.scoreTarget.innerHTML
    this.totalTimeTarget.value = new Date().getTime() - this.startTime
    this.formTarget.submit();
  }


  moveDown() {
    let newPosition = this.startPosition + this.gridSize
    if (newPosition <= this.arrivalPosition) {
      this.startPosition = newPosition
      this.validatedMovement()
    }
  }

  moveUp() {
    let newPosition = this.startPosition - this.gridSize
    if (newPosition > 0) {
      this.startPosition = newPosition
      this.validatedMovement()
    }
  }

  moveLeft() {
    let newPosition = this.startPosition - 1
    if (newPosition % this.gridSize != 0) {
      this.startPosition = newPosition
      this.validatedMovement()
    }
  }

  moveRight() {
    let newPosition = this.startPosition + 1
    if (newPosition % this.gridSize != 1) {
      this.startPosition = newPosition
      this.validatedMovement()
    }
  }

  validatedMovement() {
    this.scoreTarget.innerHTML = parseInt(this.scoreTarget.innerHTML) + 1;
    this.eatGhost()
    this.elementsPlacing()
  }

  eatGhost() {
    if (this.ghostsPosition.includes(this.startPosition)) {
      this.ghostsPosition = this.ghostsPosition.filter(pos => pos != this.startPosition)
    }
  }

  keyDown(event) {
    switch (event.code) {
      case 'ArrowUp':
        this.moveUp()
        break
      case 'ArrowDown':
        this.moveDown()
        break
      case 'ArrowRight':
        this.moveRight()
        break
      case 'ArrowLeft':
        this.moveLeft()
        break
    }
  }

  cleanGrid(){
    let i
    for (i = 1; i <= this.cells.length; i++) {
      this.cells[i - 1].classList.remove("target")
      this.cells[i - 1].classList.remove("ghost")
    }
  }

  elementsPlacing() {
    let i
    this.cleanGrid()
    this.cells[this.startPosition - 1].classList.add("target")
    this.cells[this.arrivalPosition - 1].classList.add("arrival")
    for (i = 0; i < this.ghostsPosition.length; i++) {
      this.cells[this.ghostsPosition[i] - 1].classList.add("ghost")
    }
    if (this.startPosition == this.arrivalPosition && this.ghostsPosition.length < 1 ) {
      this.endGame()
    }
  }

  disconnect() {
    stopStopWatch(this.stopWatch_id)
  }
}
