const counter = (duration) => {
  // Set the date we're counting down to
  var countDownDate = new Date().getTime() + duration*1000;
  // Update the count down every 1 second
  var x = setInterval(function() {
    // Get todays date and time
    var now = new Date().getTime();
    // Find the distance between now and the count down date
    var distance = countDownDate - now;
    // Time calculations for days, hours, minutes and seconds
    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    // Output the result in an element with id="counter"
    if (hours > 0) {
    document.getElementById("counter").innerHTML = hours + "h "
    + minutes + "mn " + seconds + "s ";
    }
    else {
    document.getElementById("counter").innerHTML = minutes + "mn " + seconds + "s ";
    }
    // If the count down is over, write some text
    if (distance < 0) {
      clearInterval(x);
      document.getElementById("counter").innerHTML = "Fini";
      document.getElementsByClassName("btn")[0].disabled=false;
      document.getElementsByClassName("input")[0].readOnly=true;
    }
  }, 1000);
}
export{counter};
