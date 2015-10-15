class InappropriateProductsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :verify_admin

  def index
  	@inappropriateProducts = Product.joins(:feedbacks).where("inappropriate = 1").uniq
  end

  private
  def verify_admin
  	if !current_user.try(:admin?)
  		flash[:alert] = "Acceso denegado."
  		redirect_to root_path
  	end
  end

end
