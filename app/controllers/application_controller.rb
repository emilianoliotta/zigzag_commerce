class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :admin_data

  def admin_data
    if current_user.try(:admin?)
      feedbacks = Feedback.all
      @inappropriates = feedbacks.where(inappropriate: 1).group("product_id").count.count
    end   
  end


end
