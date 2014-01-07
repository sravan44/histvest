class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|      
      t.integer :topic_id
      t.timestamps
    end
  end
end
