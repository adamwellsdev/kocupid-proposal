Kocupid.Views.MessagesIndex = Backbone.CompositeView.extend({
	template: JST['messages/index'],
	events: {
		'click .sent' : 'sent',
		'click .received' : 'received'
	},

	initialize: function () {
		this.listenTo(this.collection, 'sync', this.render);
		this.sent();
	},

	sent: function () {
		this.clearMessages();
		this.addMessages(this.sentMessages());
		this.render();
	},

	received: function () {
		this.clearMessages();
		this.addMessages(this.receivedMessages());
		this.render();
	},

	addMessage: function (message) {
		var indexItem = new Kocupid.Views.MessagesIndexItem({ model: message });
		this.addSubview('.message-box', indexItem);
	},

	sentMessages: function () {
		sent = this.collection.where({ sender_id: Kocupid.currentUserId });
		return new Kocupid.Collections.Messages(sent);
	},

	receivedMessages: function () {
		received = this.collection.where({ recipient_id: Kocupid.currentUserId });
		return new Kocupid.Collections.Messages(received);
	},

	addMessages: function (collection) {
		collection.each(function (message) {
			this.addMessage(message);
		}.bind(this));
	},

	clearMessages: function() {
		var subviews = this.subviews();
		subviews['.message-box'] = [];
	},

	render: function () {
		var content = this.template();
		this.$el.html(content);
		this.attachSubviews();
		return this;
	}
});