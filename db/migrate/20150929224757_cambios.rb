class Cambios < ActiveRecord::Migration
  def change

  	drop_table :product_categories

  	add_column :products, :category_id, :integer

  end
end
