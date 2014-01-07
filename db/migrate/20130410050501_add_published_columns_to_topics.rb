class AddPublishedColumnsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :published_start, :date
    add_column :topics, :published_end, :date    
  end
end
