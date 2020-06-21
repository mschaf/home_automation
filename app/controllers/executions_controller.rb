class ExecutionsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    build_execution
    if save_execution
      redirect_back fallback_location: @execution.actor
    else
      flash[:danger] = "Action \"#{@execution.action}\" failed."
      redirect_back fallback_location: @execution.actor
    end
  end

  private

  def build_execution
    @execution ||= Execution.new
    @execution.attributes = execution_params
  end

  def save_execution
    @execution.save
  end

  def execution_params
    execution_params = params[:execution]
    execution_params ? execution_params.permit(:actor_id, :action, :parameters) : {}
  end

end