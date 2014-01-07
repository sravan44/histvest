class ChangeColumnApikeyInReferenceSources < ActiveRecord::Migration
  def change
  	rename_column :reference_sources, :apikey, :apiurl
  end
end
