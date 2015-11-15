class SalesController < ApplicationController

	before_action :authenticate_user!, only: [:index, :new, :create, :show]
	skip_before_action :verify_authenticity_token, only: [:notifications]

  def index
    @sales = current_user.sales.order(id: :desc)
    @sales.each do |s|
      if s.payment_id.nil?
        s.destroy
      end
    end
    @sales = current_user.sales.order(id: :desc)
  end

  def new
  	@sale = Sale.new
  end

  def create
  	@sale = Sale.new(sale_params)
  	@sale.user = current_user

  	orders = current_user.orders
  	suma = 0
  	description = ""
    
    orders.each do |o|
      suma += o.product.price * o.quantity
      description += "<tr><td id='sale-td-cell'>$" + o.product.price.to_s + "</td><td id='sale-td-cell'>" + o.quantity.to_s + "</td><td id='sale-td-cell'>" + o.product.title.to_s + "(" + o.product.id.to_s + ") </td><td id='sale-td-cell'>$" + (o.product.price * o.quantity).to_s + "</td></tr>"
    end

    @sale.description = description

    if description.length > 256
    	desc_truncated256 = description[0..255]
    else
    	desc_truncated256 = description
    end

    if description.length > 600
    	desc_truncated600 = description[0..599]
    else
    	desc_truncated600 = description
    end

    @sale.save

		preference_data = {"items"=> [ "title"=> "Compra en Zigzag Commerce", "quantity"=> 1, "unit_price"=> suma , "currency_id"=> "ARS", "description"=> desc_truncated256 ],"payer"=> {"name" => @sale.first_name, "surname" => @sale.last_name, "email" => @sale.user.email, "phone" => {"area_code" => @sale.area_code, "number" => @sale.number}, "address" => {"zip_code" =>  @sale.zip_code, "street_name" => @sale.street, "street_number" => @sale.street_number.to_i}},"back_urls"=>  {"success"=> "https://zigzag-commerce.herokuapp.com/sales", "pending"=> "https://zigzag-commerce.herokuapp.com/sales", "failure" => "https://zigzag-commerce.herokuapp.com/sales" }, "aditional_info" => desc_truncated600, "external_reference" => @sale.id.to_s }
		@preference = MP_CLIENT.create_preference(preference_data)

    @sale.preference_id = @preference['response']['id']

    @sale.save

    @sum = suma

    if @sale.errors.any?
    	flash[:alert] = "Hubo un error con la compra, vuelva a intentarlo luego. (Si el error continúa tome contacto con ZigZag Commerce)."
    	redirect_to root_path
    else
    	flash[:notice] = "Sus datos fueron guardados. Ahora puede completar la compra."
      current_user.orders.destroy_all
    end
  end

  def notifications
		if params[:topic] == "merchant_order"
			merchant_order = MP_CLIENT.get("/merchant_orders/"+params[:id].to_s)
			sale = Sale.where(id: merchant_order['response']['external_reference'].to_i).first
			if !sale.nil?
				sale.merchant_id = merchant_order['response']['id'].to_s
				sale.save
			end
		elsif params[:topic] == "payment"
			payment = MP_CLIENT.get_payment_info(params[:id].to_s)
			if payment['status'] == "404"
				payment = MP_CLIENT.get("/collections/notifications/"+params[:id].to_s)
			end
			sale = Sale.where(id: payment['response']['collection']['external_reference'].to_i).first
			if !sale.nil?
				sale.payment_id = payment['response']['collection']['id'].to_s
				sale.save
			end
		end

  	render :nothing => true, status: 200

  end

  def show
  	
  end

  private

  def sale_params
    params.require(:sale).permit(:first_name, :last_name, :area_code, :number, :zip_code, :street, :street_number)
  end

end
