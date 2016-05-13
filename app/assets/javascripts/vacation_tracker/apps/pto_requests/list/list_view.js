VacationTracker.module("PtoRequestsApp.List", function(List, VacationTracker, Backbone, Marionette, $, _) {
  List.Layout = Marionette.LayoutView.extend({
    template: JST["vacation_tracker/apps/pto_requests/list/templates/pto_request_list_layout"],
    regions: {
      ptoRequestsRegion: "#pto-requests-region",
    }
  });

  List.PtoRequest = Marionette.ItemView.extend({
    template: JST["vacation_tracker/apps/pto_requests/list/templates/pto_request_list_item"],
    tagName: "tr",

    events: {
      "click": "highlightName",
    }
  });
  _.extend(List.PtoRequest.prototype, {
    highlightName: function() {
      this.$el.toggleClass("warning");
    }
  });

  var NoPtoRequestsView = Marionette.ItemView.extend({
    template: JST["vacation_tracker/apps/pto_requests/list/templates/pto_request_list_none"],
    tagName: "tr",
    className: "alert"
  });

  List.PtoRequests = Marionette.CompositeView.extend({
    tagName: "table",
    className: "table table-hover",
    template: JST["vacation_tracker/apps/pto_requests/list/templates/pto_request_list"],
    emptyView: NoPtoRequestsView,
    childView: List.PtoRequest,
    childViewContainer: "tbody",

    // initialize: function() {
    //   this.listenTo(this.collection, "reset", function() {
    //     this.$(this.childViewContainer).html('');
    //
    //     this.attachHtml = function(collectionView, childView, index) {
    //       collectionView.$el.append(childView.el);
    //     }
    //   });
    // }
  });
  // _.extend(List.PtoRequests.prototype, {
  //   onRenderCollection: function() {
  //     this.attachHtml = function(collectionView, childView, index) {
  //       collectionView.$el.prepend(childView.el);
  //     }
  //   }
  // });
});
