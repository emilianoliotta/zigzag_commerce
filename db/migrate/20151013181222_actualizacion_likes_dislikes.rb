class ActualizacionLikesDislikes < ActiveRecord::Migration
  def change
  	change_table :products do |t|
  		t.remove :likes, :dislikes
  	end
  end
end
