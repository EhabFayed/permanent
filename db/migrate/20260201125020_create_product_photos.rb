class CreateProductPhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :product_photos do |t|
      t.references :product, null: false, foreign_key: true
      t.string :alt_ar
      t.string :alt_en
      t.boolean :is_landing
      t.timestamps
    end
  end
end
