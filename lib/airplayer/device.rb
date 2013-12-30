module AirPlayer
  class Device
    class << self
      def devices
        Airplay.devices.to_a
      rescue Airplay::Browser::NoDevicesFound
        abort 'AirPlay devices not found.'
      end

      def get(device_number = 0)
        if exist?(device_number)
          Airplay[devices.at(device_number).name]
        else
          puts "Device number #{device_number} is not found. So choose #{default.name}."
          default
        end
      end

      def exist?(device_number)
        !!devices.at(device_number)
      end

      def default
        devices.first
      end
    end
  end
end
