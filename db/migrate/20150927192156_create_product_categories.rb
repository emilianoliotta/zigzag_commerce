class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.integer :category_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
