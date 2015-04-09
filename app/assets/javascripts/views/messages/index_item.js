Kocupid.Views.MessagesIndexItem = Backbone.View.extend({
	template: JST['messages/index_item'],
	tagName: 'li',

	initialize: function () {
		this.listenTo(this.model, 'sync', this.render);
	},

	render: function () {
		var content = this.template({ message: this.model });
		this.$el.html(content);
		return this;
	}
});