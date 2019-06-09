class Schedule < ApplicationRecord

  belongs_to :actor

  def execute
    actor.execute(action, parameters)
  end


  def self.execute_schedules
    time = Time.now
    schedules_to_execute = Schedule.where("extract(hour from execute_at) = ? AND extract(minute from execute_at) = ?", time.strftime('%H'), time.strftime('%M'))
    schedules_to_execute.each do |schedule|
      schedule.execute
    end
  end

end