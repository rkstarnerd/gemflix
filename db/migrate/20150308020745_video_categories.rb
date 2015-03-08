class VideoCategories < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.integer :video_id, :category_id
    end
  end
end
