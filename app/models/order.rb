class Order < ActiveRecord::Base

	belongs_to :user
	belongs_to :product

	validates :quantity, :product_id, :user_id, :allow_blank => false, :allow_nil => false, :on => :create, presence: true

end
