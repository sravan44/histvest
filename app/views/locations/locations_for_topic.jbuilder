json.array! @locations do |location|
	json.id location.id
	json.title location.address
	json.lat location.latitude
	json.lng location.longitude
	json.selected location.matched_topics.to_i > 0
	json.is_editable location.total_topics.to_i == 0 || location.matched_topics.to_i > 0
end