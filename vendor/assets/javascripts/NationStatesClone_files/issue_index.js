NationStatesClone.Views.IssuesIndex = Backbone.View.extend({
  template: JST['issues/index'],

  events: {
    "click .logout": "logout",
    "click .submit": "getIssues"
  },

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({
      issues: this.collection,
      nation: this.model
    });
    this.$el.html(content);
    return this;
  },

  logout: function (event) {
    $.ajax({
      url: "/api/nations/" + NationStatesClone.CURRENT_NATION.nation,
      dataType: "json",
      method: "DELETE",
      success: function () {
        Backbone.history.navigate("", { trigger: true });
      }
    });
  },

  getIssues: function (event) {
    $.ajax({
      url: "/api/get_issues",
      dataType: "json",
      method: "GET",
      success: function () {
        Backbone.history.loadUrl(Backbone.history.fragment);
      }
    });
  }
});