class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.integer :category
      t.string :description_ar
      t.string :description_en
      t.boolean :is_published, default: false
      t.string :size_ar
      t.string :size_en
      t.timestamps
    end
  end
end
