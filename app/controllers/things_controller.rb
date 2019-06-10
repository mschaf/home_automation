class ThingsController < ApplicationController

  def index
    load_things
  end

  def show
    load_thing
  end

  private

  def load_things
    @things ||= thing_scope.to_a
  end

  def load_thing
    @thing ||= thing_scope.find(params[:id])
  end

  def thing_scope
    Thing.all
  end

end