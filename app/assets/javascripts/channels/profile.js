App.product = App.cable.subscriptions.create("ProfileChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

   received: function(data) {
    $("#profile_image").html(data['message']);
  }
});






