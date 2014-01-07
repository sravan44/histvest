class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def admin
  	@topic = Topic.first
  	#authorize! :edit, @topic
  end
end
