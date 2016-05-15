VacationTracker.module("PtoSummaryApp.Show", function(Show, VacationTracker, Backbone, Marionette, $, _) {
  var Controller = Marionette.Controller.extend({
    showPtoSummary: function() {
      var loadingView = new VacationTracker.Common.Views.Loading();
      VacationTracker.regions.ptoSummary.show(loadingView);

      var fetchingPtoSummary = VacationTracker.request("ptoSummary:entity");

      var self = Show.Controller;
      $.when(fetchingPtoSummary).done(function(ptoSummary) {
        var ptoSummaryView = new Show.PtoSummary({model: ptoSummary});

        VacationTracker.regions.ptoSummary.show(ptoSummaryView);
      }).fail(function() {
        alert("An unprocessed error happened. Please try again!");
      });
    }
  });

  Show.Controller = new Controller();
});
