class OrdersController < ApplicationController

	before_action :authenticate_user!

  def index
  	@orders = current_user.orders

  end

  def destroy
  	order = current_user.orders.find(params[:id])
  	if order
  		order.destroy
  		flash[:notice] = "Orden eliminada."
  	else
  		flash[:alert] = "La orden no se eliminó."
  	end
  	redirect_to orders_index_path
  end
end
