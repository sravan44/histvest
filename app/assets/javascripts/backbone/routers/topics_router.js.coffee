class Histvest.Routers.TopicsRouter extends Backbone.Router
	routes:
		"topics"		  : "newTopicPost"
		"topics/new"      : "newTopic"
		"topics/:id" 	  : "editTopicPost"
		"topics/:id/edit" : "editTopic"

	topicForm: ->
		@reference_list = new Histvest.Views.Topics.ReferenceListView(collection: @added_references_collection)
		@reference_list.render()

		$("#reference-source-tabs").tabs()

		@search_form = new Histvest.Views.Topics.SearchFormView(added_references_collection: @added_references_collection)
		$('#reference-search-container').html(@search_form.render().el)

		window.geocoder = new google.maps.Geocoder()

		center = new google.maps.LatLng(59.2981, 10.4236)
		opts = { zoom: 8, center: center, mapTypeId: google.maps.MapTypeId.ROADMAP }
		window.map = new google.maps.Map(document.getElementById("map_canvas"), opts)
		@map_view = new Histvest.Views.Topics.LocationMapView(map: window.map, collection: @markers_list)

		@markers_list.fetch()

	newTopic: ->
		@added_references_collection = new Histvest.Collections.AddedReferencesCollection()

		@markers_list = new Histvest.Collections.LocationMarkerCollection()
		@markers_list.url = "/locations_for_topic"		
		
		@topicForm()

	editTopic: (id) ->
		@added_references_collection = new Histvest.Collections.AddedReferencesCollection()
		@added_references_collection.addPreviouslyAddedReferences(id)

		@markers_list = new Histvest.Collections.LocationMarkerCollection()		
		@markers_list.url = "/locations_for_topic?topic_id=" + id

		@topicForm()


	newTopicPost: ->
		if $('#map_canvas').size() > 0
			@newTopic()


	editTopicPost: (id)-> 
		if $('#map_canvas').size() > 0
			@editTopic(id)