Histvest.Views.Topics ||= {}

class Histvest.Views.Topics.DeletedReferencesListView extends Backbone.View
	template: JST["backbone/templates/topics/deleted_reference_input"]

	el: '#deleted-references-list-container'

	tagName: 'ul'

	initialize: ->
		@collection.on('reset', @render, this)
		@collection.on('add', @render, this)

	render: ->
		$('#deleted-references-list-container li').remove()
		@collection.each(@appendReference)
		this

	appendReference: (reference) =>
		if not reference.randomId
			$(@el).append(@template(reference: reference))
