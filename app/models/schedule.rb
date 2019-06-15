class Schedule < ApplicationRecord

  belongs_to :actor
  has_defaults execute_on_monday: true,
               execute_on_tuesday: true,
               execute_on_wednesday: true,
               execute_on_thursday: true,
               execute_on_friday: true,
               execute_on_saturday: true,
               execute_on_sunday: true

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