class RenameAuthorToCreatorInReference < ActiveRecord::Migration
  def change
    rename_column :references, :author, :creator
  end
end
