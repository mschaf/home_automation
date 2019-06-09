class Actor::Plug < ApplicationRecord
  acts_as :actor

  def on
    thing.turn_on
  end

  def off
    thing.turn_off
  end

  def actions
    ['on', 'off']
  end

end