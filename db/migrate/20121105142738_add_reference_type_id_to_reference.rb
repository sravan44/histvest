class AddReferenceTypeIdToReference < ActiveRecord::Migration
  def change
    add_column :references, :reference_type_id, :integer

  end
end
