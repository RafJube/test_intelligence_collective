const startCounter = (duration, callback) => {
  // Set the date we're counting down to
  var countDownDate = new Date().getTime() + duration*1000;
  // Update the count down every 1 second
  var interval = setInterval(function() {
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
    if (distance <= 0) {
      document.getElementById("counter").innerHTML = 0 + "mn " + 0 + "s ";
      stopCounter(interval)
      callback();
    }
  }, 1000);
  return interval;
}

const stopCounter = (counter_id) => {
  clearInterval(counter_id);
}

export{ startCounter, stopCounter};
