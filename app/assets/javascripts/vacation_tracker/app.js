var VacationTracker = new Marionette.Application();

VacationTracker.getCurrentRoute = function() {
  return Backbone.history.fragment;
};

VacationTracker.on("before:start", function(options) {
  options || (options = {});

  VacationTracker.i18n = {
    acceptedLanguages: options.acceptedLanguages || [],
    currentLanguage: "en"
  };

  var RegionContainer = Marionette.LayoutView.extend({
    el: "#app-container",
    regions: {
      header: "#header-region",
      main: "#main-region",
    }
  });

  VacationTracker.regions = new RegionContainer();
});

VacationTracker.on("start", function(options) {
  if (Backbone.history) {
    Backbone.history.start();

    if (this.getCurrentRoute() === "") {
      VacationTracker.trigger("ptoRequests:list");
    }
  }
});
