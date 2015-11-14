class SalesController < ApplicationController

	before_action :authenticate_user!, only: [:index, :new, :create, :show]
	skip_before_action :verify_authenticity_token, only: [:notifications]

  def index
  end

  def new
  	@sale = Sale.new
  end

  def create
  	@sale = Sale.new(sale_params)
  	@sale.user = current_user

  	orders = current_user.orders
  	suma = 0
  	description = "Venta: <br> "
    
    orders.each do |o|
      suma += o.product.price * o.quantity
      description += "[ $" + (o.product.price * o.quantity).to_s + " ]  -> " + o.quantity.to_s + " x " + o.product.title.to_s + "(ID: " + o.product.id.to_s + ") <br>"
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

    if @sale.errors.any?
    	flash[:alert] = "Hubo un error con la compra, vuelva a intentarlo luego. (Si el error continúa tome contacto con ZigZag Commerce)."
    	redirect_to root_path
    else
    	flash[:notice] = "Sus datos fueron guardados. Ahora puede completar la compra."
    end
  end

  def notifications
		if params[:topic] == "merchant_order"
			merchant_order = MP_CLIENT.get("/merchant_orders/"+params[:id].to_s)
			sale = Sale.find(merchant_order['response']['external_reference'].to_i)
			sale.merchant_id = merchant_order['response']['id'].to_s
			sale.save
		elsif params[:topic] == "payment"
			payment = MP_CLIENT.get_payment_info(params[:id].to_s)
			sale = Sale.find(payment['response']['collection']['external_reference'].to_i)
			sale.payment_id = payment['response']['collection']['id'].to_s
			sale.save
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
