VacationTracker.module("Routers.PtoRequestsApp", function(PtoRequestsAppRouter, VacationTracker, Backbone, Marionette, $, _) {
  var API = {
    listPtoRequests: function(options) {
      options || (options = {page: 1});
      VacationTracker.PtoRequestsApp.List.Controller.listPtoRequests(options);
    },
  };

  this.listenTo(VacationTracker, "ptoRequests:list", function() {
    API.listPtoRequests();
  });
});
