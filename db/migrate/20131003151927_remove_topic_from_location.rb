class RemoveTopicFromLocation < ActiveRecord::Migration
  def up
  	remove_column :locations, :topic_id
  end

  def down
  	add_column :locations, :topic_id, :integer
  end
end
