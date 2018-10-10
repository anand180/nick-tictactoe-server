document.addEventListener("DOMContentLoaded", function() {
  App.move = App.cable.subscriptions.create({
    channel: "MoveChannel",
    game_id: document.getElementById("game").innerText
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      const position = data.position
      const space = document.getElementById(position)
      space.innerHTML = data.type

      const display = document.getElementById("form").style.display
      if(display === "inline") {
        document.getElementById("form").style.display = "none"
      }
      else if(display === "none") {
        document.getElementById("form").style.display = "inline"
      }
    }
  });
})
