class Actor::Plug < ApplicationRecord
  acts_as :actor

  def on
    if thing.turn_on
      update!(state: true)
    end
  end

  def off
    if thing.turn_off
      update!(state: false)
    end
  end

  def actions
    ['on', 'off']
  end

  def humanized_state
    if state
      'on'
    else
      'off'
    end
  end
end