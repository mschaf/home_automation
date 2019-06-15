class Thing < ApplicationRecord

  has_many :actors
  has_many :sensors

  def query_sensors

  end

  def update_last_seen
    update!(last_seen: Time.now)
  end

  def remove_last_seen
    update!(last_seen: nil)
  end

  def self.query_sensors
    Thing.all.each do |thing|
      thing.query_sensors
    end
  end

end