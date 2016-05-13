VacationTracker.module("Entities", function(Entities, VacationTracker, Backbone, Marionette, $, _) {
  Entities.PtoRequest = Backbone.Model.extend({
    urlRoot: "api/v1/pto_requests",

    defaults: {
      start_date: "",
      end_date: "",
      hours: "",
      status: "",
      pto_type: "",
    },
  });

  Entities.PtoRequestCollection = Backbone.Collection.extend({
    url: "api/v1/pto_requests",
    model: Entities.PtoRequest,
    comparator: "start_date",
  });

  var API = {
    getPtoRequestEntities: function(options) {
      var ptoRequests = new Entities.PtoRequestCollection([], options);
      delete options.parameters;
      var defer = $.Deferred();
      options || (options = {});
      defer.then(options.success, options.error);
      var response = ptoRequests.fetch();
      response.done(function() {
        defer.resolveWith(response, [ptoRequests]);
      });
      response.fail(function() {
        defer.rejectWith(response, arguments);
      });

      return defer.promise();
    },
  }

  VacationTracker.reqres.setHandler("ptoRequest:entities", function(options) {
    return API.getPtoRequestEntities(options);
  });
});
