var VacationTracker = new Marionette.Application();

VacationTracker.getCurrentRoute = function() {
  return Backbone.history.fragment;
};

VacationTracker.on("before:start", function(options) {
  options || (options = {});

  var RegionContainer = Marionette.LayoutView.extend({
    el: "#app-container",
    regions: {
      header: "#header-region",
      ptoSummary: "#pto-summary-region",
      main: "#main-region",
    }
  });

  VacationTracker.regions = new RegionContainer();
});

VacationTracker.on("start", function(options) {
  if (Backbone.history) {
    Backbone.history.start();

    if (this.getCurrentRoute() === "") {
      VacationTracker.trigger("ptoSummary:show");
      VacationTracker.trigger("ptoRequests:list");
    }
  }
});
