VacationTracker.module("PtoSummaryApp.Show", function(Show, VacationTracker, Backbone, Marionette, $, _) {
  Show.PtoSummary = Marionette.ItemView.extend({
    template: JST["vacation_tracker/apps/pto_summary/show/templates/pto_summary_view"]
  });
});

