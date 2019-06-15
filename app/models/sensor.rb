class Sensor < ApplicationRecord

  belongs_to :thing

  has_many :sensor_values

  def save_reading(value)

      update!(current_value: value)

      last_value = sensor_values.last

      if !last_value || (last_value && sensor_values.last.created_at < 5.minutes.ago)
        sensor_values.create!(value: value)
      end

  end

  def aggregate_by(interval)
    case interval
    when 'hour'
      now = Time.at(Time.now.to_i - (Time.now.to_i % 5.minutes))
      result = aggregate_by_interval(now - 1.hour, now, 5.minutes)
      {labels: result[:time].map { |time| Time.find_zone("UTC").parse(time).localtime.strftime('%H:%M') },  values: result[:value] }
    when 'day'
      now = Time.at(Time.now.to_i - (Time.now.to_i %  15.minutes))
      result = aggregate_by_interval(now - 1.day, now, 15.minutes)
      {labels: result[:time].map { |time| Time.find_zone("UTC").parse(time).localtime.strftime('%H:%M') },  values: result[:value] }
    when 'week'
      now = Time.at(Time.now.to_i - (Time.now.to_i % 3.hours))
      result = aggregate_by_interval(now - 1.week, now, 3.hours)
      {labels: result[:time].map { |time| Time.find_zone("UTC").parse(time).localtime.strftime('%d.%m. %H:%M') },  values: result[:value] }
    when 'month'
      now = Time.at(Time.now.to_i - (Time.now.to_i % 1.day))
      result = aggregate_by_interval(now - 1.month, now, 1.day)
      {labels: result[:time].map { |time| Time.find_zone("UTC").parse(time).localtime.strftime('%d.%m.%y') },  values: result[:value] }
    else
      {}
    end
  end

  def aggregate_by_interval(start_at, end_at, interval)
    start_at_string = start_at.utc.strftime('%F %T')
    end_at_string = end_at.utc.strftime('%F %T')
    interval_string = interval.to_i

    sql = <<-SQL
      SELECT
          value,
          count,
          times.time
      FROM
          (
              SELECT
                  generate_series AS time
              FROM
                  generate_series('#{start_at_string}'::timestamp, '#{end_at_string}'::timestamp, INTERVAL '#{interval_string}' SECOND)
          ) AS times
          LEFT OUTER JOIN
          (
              SELECT
                  COUNT(*) as count,
                  AVG(value) as value,
                  to_timestamp(ceil((extract('epoch' from created_at) / #{interval_string})) * #{interval_string}) AT TIME ZONE 'UTC' as time
              FROM
                  sensor_values
              WHERE
                  sensor_id = #{id}
                  AND created_at > '#{start_at_string}'::timestamp - INTERVAL '#{interval_string}' SECOND
                  AND created_at < '#{end_at_string}'::timestamp
              GROUP BY
                  time
          ) values
      ON
          times.time = values.time
      ORDER BY
          times.time;
    SQL

    connection = ActiveRecord::Base.connection
    result = connection.execute(sql)

    {time: result.field_values('time'), value: result.field_values('value').map{ |value| value && value.round(1) }}
  end

end