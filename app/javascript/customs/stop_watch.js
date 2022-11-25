const startStopWatch = () => {
  // Set the date we're counting down to
  var stopWatchDate = new Date().getTime();
  // Update the count down every 1 second
  var interval = setInterval(function() {
    // Get todays date and time
    var now = new Date().getTime();
    // Find the distance between now and the count down date
    var distance = now - stopWatchDate;
    // Time calculations for days, hours, minutes and seconds
    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    // Output the result in an element with id="counter"
    if (hours > 0) {
    document.getElementById("stop-watch").innerHTML = hours + "h "
    + minutes + "mn " + seconds + "s ";
    }
    else {
    document.getElementById("stop-watch").innerHTML = minutes + "mn " + seconds + "s ";
    }
  }, 1000);
  return interval;
}

const stopStopWatch = (counter_id) => {
  clearInterval(counter_id);
}

export{ startStopWatch, stopStopWatch};
