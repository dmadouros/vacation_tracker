VacationTracker.module("Common.Views", function(Views, VacationTracker, Backbone, Marionette, $, _) {
  Views.Loading = Marionette.ItemView.extend({
    template: JST["vacation_tracker/common/templates/loading_view"],
  });
  _.extend(Views.Loading.prototype, {
    title: "Loading Data",
    message: "Please wait, data is loading",

    serializeData: function() {
      return {
        title: Marionette.getOption(this, "title"),
        message: Marionette.getOption(this, "message"),
      };
    },

    onShow: function() {
      var opts = {
        lines: 10,
        length: 10,
        width: 5,
        radius: 10,
        corners: 1,
        rotate: 0,
        direction: 1,
        color: "#000",
        speed: 1,
        trail: 60,
        shadow: false,
        hwaccel: false,
        className: "spinner",
        zIndex: 2e9,
        top: "10px",
        left: "auto"
      };
      $('#spinner').spin(opts);
    }
  });
});
