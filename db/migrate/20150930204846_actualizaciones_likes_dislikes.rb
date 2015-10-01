class ActualizacionesLikesDislikes < ActiveRecord::Migration
  def change
  	add_column :products, :likes, :integer
  	add_column :products, :dislikes, :integer
  	add_column :products, :location, :string
  end
end
