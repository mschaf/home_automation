class ThingsController < ApplicationController

  def index
    load_things
  end

  def show
    load_thing
  end

  def new
    build_thing
  end

  def create
    build_thing
    if save_thing
      redirect_to things_path
    else
      render 'new'
    end
  end

  def edit
    load_thing
    build_thing
  end

  def update
    load_thing
    build_thing
    if save_thing
      redirect_to things_path
    else
      render 'edit'
    end
  end

  def destroy
    load_thing
    @thing.destroy
    redirect_to things_path
  end

  private

  def load_things
    @things ||= thing_scope.order(:name).to_a
  end

  def load_thing
    @thing ||= thing_scope.find(params[:id])
  end

  def save_thing
    @thing.save
  end

  def thing_scope
    Thing.all
  end

  def build_thing
    @thing ||= thing_scope.build
    @thing.attributes = thing_params
  end

  def thing_params
    thing_params = params[:thing]
    thing_params ? thing_params.permit(:type, :name, :address, :identifier) : {}
  end

end