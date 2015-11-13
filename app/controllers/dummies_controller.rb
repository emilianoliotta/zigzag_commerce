class DummiesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def on_success
  	@dummy = Dummy.new

  	if params[:topic]
  		@dummy.success = params[:topic].to_s + params[:id].to_s
  	end
  	@dummy.save

  	render :nothing => true, status: 200

  end

  def on_failure

  end

  def on_pending

  end
end
