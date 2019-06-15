class SensorUpload < ActiveType::Object

  attribute :json

  validates :json, presence: true

  # {
  #     "current_readings": {
  #         "temperature": 12,
  #         "humidity": 50
  #     },
  #     "thing": "test_thing"
  # }


  def save
    parsed_json = JSON.parse(json, symbolize_names: true)
    thing_identifier = parsed_json[:thing]
    current_readings = parsed_json[:current_readings]

    thing = Thing.find_by(identifier: thing_identifier)

    if thing
      thing.update_last_seen
      current_readings.each do |sensor_identifier, reading|
        sensor = thing.sensors.find_by(identifier: sensor_identifier)
        if sensor
          sensor.save_reading(reading)
        end
      end
    end

  end

end