class AddIndexToEveryIdField < ActiveRecord::Migration
  def change
  	add_index :locations, :topic_id
  	add_index :references, :reference_type_id
  	add_index :references, :reference_source_id
  	add_index :references, :topic_id
  	add_index :topics, :user_id
  end
end
