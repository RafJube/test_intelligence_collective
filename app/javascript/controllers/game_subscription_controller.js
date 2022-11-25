// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-hello-target="output"></h1>
// </div>

import { Controller } from "stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { gameId: Number, gamePlayers: Number, usersConnected: Number, targetPosition: Number, ghostsPosition: String }
  static targets = [ "gameGrid", "gameInfos", "gameUsers" ]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "GameChannel", id: this.gameIdValue, players: this.gamePlayersValue },
      { received: data =>
        {
          this.connected = data.connected
          this.startGame()
        }
      }
    )
    this.connected = this.usersConnectedValue
    this.cells = this.element.getElementsByClassName("grid-cell")
    this.ghostsPosition = Object.values(JSON.parse(this.ghostsPositionValue))
    this.cleanGrid()
    this.elementsPlacing()
    this.startGame()
    console.log(`Subscribe to the chatroom with the id ${this.gameIdValue}.`)
  }

  startGame() {
    this.gameUsersTarget.innerHTML = this.connected
    if (this.connected == this.gamePlayersValue) {
      this.gameGridTarget.classList.remove("d-none")
      document.getElementById("waiting-room").classList.add("d-none")
    } else {
      this.gameGridTarget.classList.add("d-none")
      document.getElementById("waiting-room").classList.remove("d-none")
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
    for (i = 1; i <= this.cells.length; i++) {
      if (i == this.targetPositionValue) {
        this.cells[i - 1].classList.add("target")
      }
      if (this.ghostsPosition.includes(i)){
        this.cells[i - 1].classList.add("ghost")
      }
    }
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
