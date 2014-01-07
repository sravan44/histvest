class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :title
      t.string :author
      t.integer :year
      t.string :lang
      t.string :snippet
      t.string :url

      t.timestamps
    end
  end
end
