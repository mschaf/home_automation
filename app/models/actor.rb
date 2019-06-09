class Actor < ApplicationRecord
  actable

  belongs_to :thing
  has_many :schedules

  def execute(action, parameters)
    if specific.actions.include? action
      specific.send(action)
    end
  end

  def actions
    []
  end


end