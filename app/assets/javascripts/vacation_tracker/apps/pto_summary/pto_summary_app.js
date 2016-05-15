VacationTracker.module("Routers.PtoSummaryApp", function(PtoSummaryAppRouter, VacationTracker, Backbone, Marionette, $, _) {
  var API = {
    showPtoSummary: function(options) {
      VacationTracker.PtoSummaryApp.Show.Controller.showPtoSummary(options);
    },
  };

  this.listenTo(VacationTracker, "ptoSummary:show", function() {
    API.showPtoSummary();
  });
});
