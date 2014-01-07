Histvest.Views.Topics ||= {}

class Histvest.Views.Topics.SearchResultView extends Backbone.View
	template: JST["backbone/templates/topics/search_result"]

	tagName: 'tr'

	events:
		'click .add-reference' : 'addReferenceToList' ,
		'click .loadMoreResults' : 'loadMoreResults'

	addedReferences: =>
		@addedReferencesCollection

	initialize: (options) ->
	  	@collection.on('search', @addSpinner, this)
	  	@collection.on('search', @clearOldResults, this)
	  	@collection.on('getNumberOfResults', @removeSpinner, this)
	  	@collection.on('reset', @render, this)
	  	@collection.on('add', @renderNew, this)
	  	@addedReferencesCollection = options.addedReferences
	  	Backbone.pubSub.on('removeReference', @removeReference, this);

	render: ->
		$(@options.el).empty()
		if @collection.length > 0
			@collection.each @appendReference
			$(@el).find('.loadMoreResults :not(:last)').parents('tr').remove()
		else
			$(@el).html "<tr><td align=center colspan=6>Det finnes ingen søkeresultater funnet.</td></tr>"
		this

	addSpinner: ->
		$(@collection.spinnerIcon).html(JST["backbone/templates/topics/search_spinner"])

	# Replaces spinner with number of search results.
	removeSpinner: ->
		$(@collection.spinnerIcon).html("(" + @collection.numberOfResults + ")")

	appendReference: (reference,index) =>
		class_name = if index % 2 then "evn" else "odd"
		if $( '#reference-list-container a[href="' + reference.get( 'url' ) + '"]' ).length
			class_name += ' added-reference'

		icon = if reference.get('reference_type_id') then window.reference_type_icons[reference.get('reference_type_id')] else referece_type_unknown
		
		$(@el).append(@template(reference: reference, class_name: class_name, icon: icon))

	addReferenceToList: (e) =>
		# e.target.id is the cid of the model in the collection
		$( '#' + e.target.id ).parents( 'tr' ).addClass( 'added-reference' )
		@addedReferences().add( @collection.get( Histvest.fetchClientId( e.target.id ) ) )

	clearOldResults: ->
		$(@options.el + " tr").remove()

	renderNew: (referencemodel) ->
		@render()
		this

	removeReference: (url) ->
		$( @options.el + ' a[href="' + url + '"]' ).parents( 'tr' ).removeClass( 'added-reference' )
		this

	loadMoreResults: (event) ->
		@collection.range = @collection.range + 1;
		@collection.query = $('#reference-search').val()
		@collection.fetch
			reset: false
			remove : false
			update: true
		this
