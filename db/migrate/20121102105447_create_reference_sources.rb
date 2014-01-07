class CreateReferenceSources < ActiveRecord::Migration
  def change
    create_table :reference_sources do |t|
      t.string :name
      t.string :apikey

      t.timestamps
    end
  end
end
