class AddTypestringsToReferenceTypes < ActiveRecord::Migration
  def change
  	add_column :reference_types, :typestrings, :string
  end
end
