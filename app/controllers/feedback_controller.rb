class FeedbackController < ApplicationController
  before_action :authenticate_user!, only: [:create,:destroy]
  
  def create
  	prod = Product.find(params[:product])
  	if !current_user.feedbacks.where(product: prod).any?
  	  f = Feedback.new
 	    f.product = prod
	    f.user = current_user
	    f.positive = params[:positive]
	    f.negative = params[:negative]
	    f.inappropriate = params[:inappropriate]
      f.save
      redirect_to prod
    else
      if params[:inappropriate] == "1"
      	f = current_user.feedbacks.where(product: prod).first
      	f.inappropriate = 1
      	f.save
      	if f.errors.any?
      	  flash[:alert] = errors
      	end
      end
      redirect_to prod
    end
  end

  def destroy

  end
end
