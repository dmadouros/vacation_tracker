VacationTracker.module("PtoRequestsApp.List", function(List, VacationTracker, Backbone, Marionette, $, _) {
  var Controller = Marionette.Controller.extend({
    listPtoRequests: function(options) {
      var loadingView = new VacationTracker.Common.Views.Loading();
      VacationTracker.regions.main.show(loadingView);

      var fetchingPtoRequests = VacationTracker.request("ptoRequest:entities", {parameters: options});

      var ptoRequestsListLayout = new List.Layout();

      var self = List.Controller;
      $.when(fetchingPtoRequests).done(function(ptoRequests) {
        var ptoRequestsListView = new List.PtoRequests({
          collection: ptoRequests,
        });

        self.listenTo(ptoRequestsListLayout, "show", function() {
          ptoRequestsListLayout.ptoRequestsRegion.show(ptoRequestsListView);
        });

        self.listenTo(ptoRequestsListView, "childview:ptoRequest:delete", function(childView, args) {
          var model = args.model;
          model.destroy();
        });

        VacationTracker.regions.main.show(ptoRequestsListLayout);
      }).fail(function() {
        alert("An unprocessed error happened. Please try again!");
      });
    }
  });

  List.Controller = new Controller();
});
