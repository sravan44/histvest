Histvest.Icons = 
	orphan		: "http://www.google.com/intl/en_us/mapfiles/ms/micons/yellow-dot.png"
	detached	: "http://www.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png"
	attached	: "http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png"

class Histvest.Models.LocationMarker extends Backbone.GoogleMaps.Location

	defaults:
		gOverlay: null
		geo_address: ""
		updateAddress: false
		is_new: false

	getIcon: ->			

		if(@get('selected'))
			return Histvest.Icons.attached
		
		if(@isEditable())
			return Histvest.Icons.orphan
		else	
			return Histvest.Icons.detached		

	isNew: ->
		!@id or @get('is_new')

	isEditable: ->
		@isNew() or @get('is_editable')

	isDraggable: ->
		@get('selected')

	animate: ->
		@gOverlay = @get('gOverlay')
		@gOverlay.setAnimation(google.maps.Animation.BOUNCE)
		setTimeout(=>
			@gOverlay.setAnimation(null)
		, 2000)

class Histvest.Collections.LocationMarkerCollection extends Backbone.GoogleMaps.LocationCollection
	
	model: Histvest.Models.LocationMarker