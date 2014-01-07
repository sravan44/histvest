class CreateTopicsLocationsTable < ActiveRecord::Migration
  def up
    create_table :locations_topics, :id => false do |t|
      t.belongs_to :topic
      t.belongs_to :location
    end    
  end

  def down
    drop_table :locations_topics
  end
end
