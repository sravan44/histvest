class RemoveComments < ActiveRecord::Migration
  def up
	drop_table :comments
  end

  def down
	create_table :comments do |t|
	  t.string :comment_data
	  t.references :commentable, :polymorphic => true
	  t.timestamps
  	end
  end
end
