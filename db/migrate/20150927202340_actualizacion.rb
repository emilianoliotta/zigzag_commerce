class Actualizacion < ActiveRecord::Migration
	def change
    	add_column :products, :user_id, :integer
    	add_column :pictures, :product_id, :integer
    	add_column :product_categories, :product_id, :integer
    	add_column :product_categories, :category_id, :integer
    	add_column :orders, :product_id, :integer
    	add_column :orders, :user_id, :integer
    	add_column :orders, :quantity, :integer
  	end
end
