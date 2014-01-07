Histvest.Views.Topics ||= {}

class Histvest.Views.Topics.DeletedLocationsListView extends Backbone.View
	template: JST["backbone/templates/topics/deleted_location_input"]

	el: '#deleted-locations-list-container'

	tagName: 'ul'		

	initialize: ->
		@collection.on('reset', @render, this)
		@collection.on('add', @render, this)

	render: ->
		$('#deleted-locations-list-container li').remove()
		@collection.each(@appendLocation)
		this

	appendLocation: (location) =>		
		$(@el).append(@template(location: location))

