class ActorsController < ApplicationController

  def index
    load_actors

    respond_to do |format|
      format.html
      format.json { render json: @actors.to_json }
    end
  end

  def show
    load_actor
  end

  private

  def load_actors
    @actors ||= actor_scope.to_a
  end

  def load_actor
    @actor ||= actor_scope.find(params[:id])
  end

  def actor_scope
    Actor.all
  end

end