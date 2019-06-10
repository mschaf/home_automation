class Sensor < ApplicationRecord

  belongs_to :thing

  has_many :sensor_values

end