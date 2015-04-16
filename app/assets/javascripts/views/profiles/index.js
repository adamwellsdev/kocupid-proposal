Kocupid.Views.ProfilesIndex = Backbone.CompositeView.extend({
	template: JST['profiles/index'],
	events: {
		'click .load' : 'load'
	},

	initialize: function () {
		this.shownItems = new Kocupid.Collections.Profiles();
		this.allItems = new Kocupid.Collections.Profiles();
		this.page = 0;
		this.load();

		this.addSearchBar();
		this.addProfiles();
		this.addNavbar();

		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(this.shownItems, 'add', this.addProfile);
		this.listenTo(this.shownItems, 'remove', this.removeProfile);
	},

	removeProfile: function (profile) {
		var profileView = $.grep(this.subviews()['.profiles-index'],
														 function(view) {return view.model.id === profile.id })[0];
		this.removeSubview('.profiles-index', profileView);
	},

	addNavbar: function () {
		var navbar = new Kocupid.Views.Navbar();
		this.addSubview('.navbar', navbar);
	},

	addSearchBar: function () {
		var searchBar = new Kocupid.Views.SearchBar({ collection: this.shownItems, fullCollection: this.allItems });
		this.addSubview('.search-bar', searchBar);
	},

	addProfile: function (profile) {
		var indexItem = new Kocupid.Views.ProfilesIndexItem({ model: profile });
		this.addSubview('.profiles-index', indexItem);
	},

	addProfiles: function () {
		this.shownItems.each(function (profile) {
			this.addProfile(profile);
		}.bind(this));
	},

	addSpinner: function () {
		this.button = this.$('.load');
		this.$('.load').html('<div class="spinner"><div class="loader"></div></div>')
	},

	removeSpinner: function () {
		this.$('.load').html(this.button.html());
	},

	load: function () {
		this.addSpinner();
		this.collection.fetch({ data: { page_number: this.page },
			success: function () {
				this.allItems.add(this.collection.models);
				this.subviews('.search-bar')[0].search();
				this.removeSpinner();
			}.bind(this)
		});
		this.page += 1;
	},

	render: function () {
		var content = this.template({ profiles: this.shownItems });
		this.$el.html(content);
		this.attachSubviews();
		return this;
	}
});