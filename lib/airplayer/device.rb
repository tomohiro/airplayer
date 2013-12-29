module AirPlayer
  class Device
    def devices
      Airplay.devices.to_a
    end

    def default
      devices.first
    end

    def exist?(device_number)
      !!devices.at(device_number)
    end

    def get(device_number)
      Airplay[devices.at(device_number).name]
    end

    def list
      Airplay.devices.each_with_index do |device, number|
        puts "#{number}: #{device.name} (#{device.address})"
      end
    end
  end
end
