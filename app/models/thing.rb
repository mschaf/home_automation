class Thing < ApplicationRecord

  has_many :actors
  has_many :sensors

  validates :name, presence: true
  validate :address_or_indentifier

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

  def to_s
    name
  end

  private

  def address_or_indentifier
    unless address.present? || identifier.present?
      errors.add :address, 'address or identifier must be present'
      errors.add :identifier, 'address or identifier must be present'
    end
  end

end