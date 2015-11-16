class AddInitPointsToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :init_point, :string
  	add_column :sales, :sandbox_init_point, :string
  end
end
