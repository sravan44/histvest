class SearchController < ApplicationController
	def search	
		# Search published topics		
		@results = Topic.published.assoc_search(params[:term])
		
		@results.take(3).each do |r|
			SearchTopic.increment(r.title)
		end

		respond_to do |format|
			format.json do
				if @results.any?
					render json: @results.to_json(:only => [:id], :methods => [:value, :label, :avatar_path])
				else
					render json: [{id: nil, value: I18n.t('seach.no_results'), label: I18n.t('seach.no_results'), avatar_path: "/assets/rt-ukjent-icon.png"}].to_json
				end
			end

			format.html do
				if @results.any?
					redirect_to @results.first
				else
					redirect_to "/"
				end 
			end
		end
	end
end