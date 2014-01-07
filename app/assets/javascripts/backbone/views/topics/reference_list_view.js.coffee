Histvest.Views.Topics ||= {}

class Histvest.Views.Topics.ReferenceListView extends Backbone.View
	template: JST["backbone/templates/topics/search_input"]

	el: '#reference-list-container'

	tagName: 'ul'

	events:
		'click a.remove-reference' : 'removeReference'

	initialize: ->
		@deleted_references = new Histvest.Collections.ReferencesCollection()
		@deleted_references_list = new Histvest.Views.Topics.DeletedReferencesListView(collection: @deleted_references)
		@collection.on('reset', @render, this)
		@collection.on('add', @render, this)
		@collection.on('remove', @render, this)

	render: ->
		$('#reference-list-container li').remove()
		@collection.each(@appendReference)
		this

	appendReference: (reference) =>
		$(@el).append(@template(reference: reference))

	removeReference: (e) =>
		@deleted_references.add( @collection.get( Histvest.fetchClientId( e.target.id ) ) )
		Backbone.pubSub.trigger( 'removeReference', $( '#' + e.target.id ).siblings( 'a' ).attr( 'href' ) )
		@collection.remove( Histvest.fetchClientId( e.target.id ) )
