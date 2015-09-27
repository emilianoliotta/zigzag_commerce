class DeleteUserIdFromCart < ActiveRecord::Migration
  def change

  	change_table :carts do |t|
  		t.remove :user_id, :product_id
	end

	change_table :product_categories do |t|
  		t.remove :category_id, :product_id
	end
  end
end
