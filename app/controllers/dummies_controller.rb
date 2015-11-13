class DummiesController < ApplicationController
  def on_success
  	@dummy = Dummy.new

  	if params[:topic]
  		@dummy.success = params[:topic].to_s + params[:id].to_s
  	end
  	@dummy.save

  	respond_to do |format|
  		format.js{ head :ok}
  	end

  end

  def on_failure

  end

  def on_pending

  end
end
