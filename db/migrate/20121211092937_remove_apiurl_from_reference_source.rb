class RemoveApiurlFromReferenceSource < ActiveRecord::Migration
  def up
    remove_column :reference_sources, :apiurl
  end

  def down
    add_column :reference_sources, :apiurl, :string
  end
end
