class SensorUploadController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    build_sensor_upload
    if save_sensor_upload
      render json: { result: 'success' }, response_code: 200
    else
      render json: { result: 'failed' }, response_code: 400
    end
  end

  private

  def build_sensor_upload
    @sensor_upload ||= SensorUpload.new
    @sensor_upload.attributes = sensor_upload_params
  end

  def save_sensor_upload
    @sensor_upload.save
  end

  def sensor_upload_params
    sensor_upload_params = params
    sensor_upload_params ? sensor_upload_params.permit(:json) : {}
  end
  
end