class CreateSearchTopics < ActiveRecord::Migration
  def change
    create_table :search_topics do |t|
      t.string :search_string
      t.integer :view_count

      t.timestamps
    end
  end
end
