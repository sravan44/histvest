class AddReferenceSourceIdToReferences < ActiveRecord::Migration
  def change
    add_column :references, :reference_source_id, :integer

  end
end
