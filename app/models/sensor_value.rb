class SensorValue < ApplicationRecord

  belongs_to :sensor

  validates :sensor_id, :value, presence: true

  scope :aggregate_by_time, ->(time_scope) {
    case time_scope
    when 'hour'
      where(created_at: Time.now-1.hour..Time.now)
    else
      SensorValue.none
    end
  }


end