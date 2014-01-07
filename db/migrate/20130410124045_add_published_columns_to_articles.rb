class AddPublishedColumnsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published_start, :date
    add_column :articles, :published_end, :date   
  end
end
