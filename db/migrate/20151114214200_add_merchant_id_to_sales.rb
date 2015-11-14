class AddMerchantIdToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :merchant_id, :string
  end
end
