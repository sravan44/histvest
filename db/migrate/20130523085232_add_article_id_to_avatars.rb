class AddArticleIdToAvatars < ActiveRecord::Migration
  def change
    add_column :avatars, :article_id, :integer
  end
end
