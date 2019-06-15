class SensorsController < ApplicationController

  def show
    load_sensor
  end

  private

  def load_sensors
    @sensors ||= sensor_scope.to_a
  end

  def load_sensor
    @sensor ||= sensor_scope.find(params[:id])
  end

  def sensor_scope
    Sensor.all
  end

end