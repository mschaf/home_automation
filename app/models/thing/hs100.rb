class Thing
  class Hs100 < Thing

    def turn_on
      if system "LC_ALL=C.UTF-8 LANG=C.UTF-8 pyhs100 --ip #{address} --plug on"
        update_last_seen
        true
      else
        remove_last_seen
        false
      end
    end

    def turn_off
      if system "LC_ALL=C.UTF-8 LANG=C.UTF-8 pyhs100 --ip #{address} --plug off"
        update_last_seen
        true
      else
        remove_last_seen
        false
      end
    end

    def query_sensors
      result = JSON.parse(`LC_ALL=C.UTF-8 LANG=C.UTF-8 pyhs100 --ip 192.168.1.61 --plug`.split("\n").last.gsub("'", '"'), symbolize_names: true)
      if($?.success?)
        update_last_seen
        power_sensor = sensors.find_by(unit: "W")
        power_sensor&.save_reading(result[:power_mw] / 1000.0)

        total_power_sensor = sensors.find_by(unit: "Wh")
        total_power_sensor&.save_reading(result[:total_wh])

        true
      else
        remove_last_seen
        false
      end

    end

  end
end