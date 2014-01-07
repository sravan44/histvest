class LocationsController < ApplicationController
  load_and_authorize_resource :except => [:locations_for_topic]
  
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    @markers = Location.all.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  def locations_for_topic
    unless params[:topic_id].blank?
      query = Location.select("#{Location.table_name}.*, (SELECT COUNT(*) FROM locations_topics WHERE location_id = #{Location.table_name}.id) as total_topics, (SELECT COUNT(*) FROM locations_topics WHERE location_id = #{Location.table_name}.id AND topic_id = #{params[:topic_id].to_i}) as matched_topics")
    else
      query = Location.select("#{Location.table_name}.*, (SELECT COUNT(*) FROM locations_topics WHERE location_id = #{Location.table_name}.id) as total_topics, 0 as matched_topics")
    end
    @locations = query.to_a
  end

end
