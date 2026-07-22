class AddTitleToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :title, :string
    add_column :products, :title_en, :string
  end
end
