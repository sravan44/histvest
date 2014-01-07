class AddTopicIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :topic_id, :integer

  end
end
