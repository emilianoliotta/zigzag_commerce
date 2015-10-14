class ActualizacionFeedback < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :product_id, :integer
  	add_column :feedbacks, :user_id, :integer
  end
end
