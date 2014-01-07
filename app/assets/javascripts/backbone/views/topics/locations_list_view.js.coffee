Histvest.Views.Topics ||= {}

class Histvest.Views.Topics.LocationsListView extends Backbone.View
	template: JST["backbone/templates/topics/location_input"]

	el: '#locations-list-container'

	tagName: 'ul'

	events:
		'click .remove-location' : 'removeLocation'
		'click a#add-location' : 'addLocation'
		'click a.update-location' : 'updateLocation'

	initialize: ->
		@deleted_locations = new Histvest.Collections.LocationsCollection()
		@deleted_locations_list = new Histvest.Views.Topics.DeletedLocationsListView(collection: @deleted_locations)

		@collection.on('reset', @render, this)
		@collection.on('add', @render, this)
		@collection.on('remove', @render, this)
		$(@el).append(JST["backbone/templates/topics/locations_form"])

	render: ->
		$('#locations-list-container li').remove()
		@collection.each(@appendLocation)
		this

	appendLocation: (location) =>				
		$('#locations-list-container ul').append(@template(location: location))		

	removeLocation: (e) =>
		if (e.bubbles)					
			@deleted_locations.add(@collection.get(Histvest.fetchClientId(e.target.id)))
			$('#'+e.target.id).parents('li').hide();
			$('#'+e.target.id).parents('li').find('input:hidden:last').val(1);			
		else 	
			id = e.target.id.replace('location-', '')
			@collection.remove(id);
			@deleted_locations.add(@collection.get(Histvest.fetchClientId(e.target.id)))
			$('#'+e.target.id).parents('li').hide();
			$('#'+e.target.id).parents('li').find('input:hidden:last').val(1);


	addLocation: (event) ->
		@collection.add( { address: $('#add-location-input').val() } )
		$('#add-location-input').val('')

	updateLocation: (event) ->
		# the purpose of this method is unknown.