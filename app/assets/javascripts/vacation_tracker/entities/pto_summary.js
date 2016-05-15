VacationTracker.module("Entities", function(Entities, VacationTracker, Backbone, Marionette, $, _) {
  Entities.PtoSummary = Backbone.Model.extend({
    urlRoot: "api/v1/overview",

    defaults: {
    },
  });

  var API = {
    getPtoSummaryEntity: function(options) {
      var ptoSummary = new Entities.PtoSummary();

      var defer = $.Deferred();
      options || (options = {});
      defer.then(options.success, options.error);

      var response = ptoSummary.fetch();
      response.done(function() {
        defer.resolveWith(response, [ptoSummary]);
      });
      response.fail(function() {
        defer.rejectWith(response, arguments);
      });

      return defer.promise();
    },
  }

  VacationTracker.reqres.setHandler("ptoSummary:entity", function(options) {
    return API.getPtoSummaryEntity(options);
  });
});
