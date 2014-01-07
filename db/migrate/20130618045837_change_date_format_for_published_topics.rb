class ChangeDateFormatForPublishedTopics < ActiveRecord::Migration
  def up
    change_column :topics, :published_start, :datetime
    change_column :topics, :published_end, :datetime
  end

  def down
    change_column :topics, :published_start, :date
    change_column :topics, :published_end, :date
  end
end
