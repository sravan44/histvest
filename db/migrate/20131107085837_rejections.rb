class Rejections < ActiveRecord::Migration
  def up
  	create_table :rejections do |t|
  		t.belongs_to :topic
  		t.belongs_to :user
  		t.text :reason
      t.boolean :unchanged, :default => true
  		t.timestamps
  	end
  end

  def down
  	drop_table :rejections
  end
end
