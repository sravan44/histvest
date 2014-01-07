class ChangeDateFormatForPublishedArticles < ActiveRecord::Migration
  def up
    change_column :articles, :published_start, :datetime
    change_column :articles, :published_end, :datetime
  end

  def down
    change_column :articles, :published_start, :date
    change_column :articles, :published_end, :date
  end
end
