class Histvest.Models.Locations extends Backbone.Model

class Histvest.Collections.LocationsCollection extends Backbone.Collection
	model: Histvest.Models.Locations

	addPreviouslyAddedLocations: (id) ->
		$.getJSON('/topics/' + id, (data) =>
			@.add(data.locations)
		)