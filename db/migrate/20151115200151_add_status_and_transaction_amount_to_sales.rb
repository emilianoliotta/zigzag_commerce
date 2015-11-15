class AddStatusAndTransactionAmountToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :status, :string
  	add_column :sales, :transaction_amount, :string
  end
end
