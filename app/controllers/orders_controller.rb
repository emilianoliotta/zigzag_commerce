class OrdersController < ApplicationController

	before_action :authenticate_user!

  def index
  	@orders = current_user.orders.order(id: :desc)
    @suma = 0
    @orders.each do |o|
      @suma += o.product.price * o.quantity
    end
  end

  def new
    current_user.orders.each do |o|
      if o.product == Product.find(params[:product])
        params[:id] = o.id
        increment_quantity
        return
      end
    end
    product = Product.find(params[:product])
    if current_user != product.user
      order = Order.new
      order.product_id = product.id
      order.user_id = current_user.id
      if params[:quantity]
        order.quantity = params[:quantity]
      else
        order.quantity = 1
      end
      order.save
      if order.errors.any?
        flash[:alert] = "Error al añadir el producto."
        redirect_to root_path
      else
        flash[:notice] = "Producto añadido con exito."
        redirect_to orders_path
      end
    else
      flash[:alert] = "No puedes comprar un producto propio."
      redirect_to root_path
    end
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

  def increment_quantity
    order = current_user.orders.find(params[:id])
    if order.quantity < 10
      order.quantity += 1
      order.save 
    end
    redirect_to orders_index_path
  end

  def decrement_quantity
    order = current_user.orders.find(params[:id])
    if order.quantity > 1
      order.quantity -= 1
      order.save 
    end
    redirect_to orders_index_path
  end

  def delete_all
    current_user.orders.destroy_all
    flash[:notice] = "Se eliminaron las ordenes de compra."
    redirect_to orders_path
  end


end
