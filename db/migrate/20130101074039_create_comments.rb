class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_data
      t.references :commentable, :polymorphic => true
      t.timestamps
    end
  end
end
