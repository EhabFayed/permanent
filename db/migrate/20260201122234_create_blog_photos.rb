class CreateBlogPhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_photos do |t|
      t.references :blog, null: false, foreign_key: true
      t.string :alt_ar
      t.string :alt_en
      t.boolean :is_landing, default: false
      t.timestamps
    end
  end
end
