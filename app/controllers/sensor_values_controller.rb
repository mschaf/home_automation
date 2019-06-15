class SensorValuesController < ApplicationController

  def index
    load_sensor_values
    respond_to do |format|
      format.json do
        render json: @sensor_values.to_json
      end
    end
  end

  private

  def load_sensor_values
    sensor = Sensor.find(params[:sensor_id])
    if sensor
      @sensor_values ||= sensor.aggregate_by(params[:interval])
    end

  end

  def sensor_value_scope
    SensorValue.all
  end

end