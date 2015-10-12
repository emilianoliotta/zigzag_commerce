class ProductsController < ApplicationController

	before_action :authenticate_user!, only: [:new,:create,:update,:destroy]
	before_action :get_products, only:[:index]
	before_action :get_categories, only:[:index]

  def new
  	@product = Product.new
  	@categories = Category.all
  end

  def index
    if params[:search]
      @products = Product.search(params[:search])
      @search = params[:search]
    else
      @products = Product.all
    end
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @products.where(category_id: params[:category_id])
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
    @in_cart
    @product = Product.find(params[:id])
    current_user.orders.each do |o|
      if o.product == @product
        @in_cart = 1
      end
    end
    if params[:like]
      @product.likes = @product.likes + 1
      @product.save
    end
    if params[:dislike]
      @product.dislikes = @product.dislikes + 1
      @product.save
    end
    @category = Category.find(@product.category_id)
    @pictures = Picture.where(product_id: @product.id)
  end

  def create
  	title = params[:product][:title]
    picture1 = params[:product][:picture1]
    picture2 = params[:product][:picture2]
    picture3 = params[:product][:picture3]
    picture4 = params[:product][:picture4]
    description = params[:product][:description]
    category = params[:product][:category_id]
    price = params[:product][:price]
    location = params[:product][:location]
    # A la variable anteriormente creada le asigno el nuevo producto
    @product = Product.create(title: title, description: description, category_id: category, location: location, price: price, likes: 0, dislikes: 0, user: current_user)

    if picture1
  		hash = Cloudinary::Uploader.upload(picture1)
  		url = hash["url"]
  		sec_url = hash["secure_url"]
  		public_id = hash["public_id"]
  		@picture = Picture.new
  		@picture.url = url
  		@picture.secure_url = sec_url
  		@picture.public_id = public_id
  		@picture.product_id = @product.id
  		@picture.save
    end

    if picture2
      hash = Cloudinary::Uploader.upload(picture2)
      url = hash["url"]
      sec_url = hash["secure_url"]
      public_id = hash["public_id"]
      @picture = Picture.new
      @picture.url = url
      @picture.secure_url = sec_url
      @picture.public_id = public_id
      @picture.product_id = @product.id
      @picture.save
    end

    if picture3
      hash = Cloudinary::Uploader.upload(picture3)
      url = hash["url"]
      sec_url = hash["secure_url"]
      public_id = hash["public_id"]
      @picture = Picture.new
      @picture.url = url
      @picture.secure_url = sec_url
      @picture.public_id = public_id
      @picture.product_id = @product.id
      @picture.save
    end

    if picture4
      hash = Cloudinary::Uploader.upload(picture4)
      url = hash["url"]
      sec_url = hash["secure_url"]
      public_id = hash["public_id"]
      @picture = Picture.new
      @picture.url = url
      @picture.secure_url = sec_url
      @picture.public_id = public_id
      @picture.product_id = @product.id
      @picture.save
    end

    if @product.errors.any?
      @categories = Category.all
      flash.now[:alert] = view_context.generate_html_error(@product)
      render :new # Vuelvo a mostrar el formulario, esta vez cargado con los datos previamente completados
    else
      if @picture
        if @picture.errors.any?
          flash[:notice] = "Producto publicado con errores en imagenes."
          redirect_to products_path
        end
      end
      flash[:notice] = "Producto publicado."
      redirect_to products_path
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @pictures = Picture.where(product_id: @product.id)
    @pictures.each do |pic|
      Cloudinary::Uploader.destroy(pic.public_id)
      pic.destroy
    end
    @product.destroy
    flash[:notice] = "Producto eliminado."
    redirect_to products_path
  end


  private


  def get_products
  	@products = Product.all
    @pictures = Picture.all
  end

  def get_categories
  	@categories = Category.all
  end
end
