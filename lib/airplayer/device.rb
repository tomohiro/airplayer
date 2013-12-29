module AirPlayer
  class Device
    class << self
      def devices
        Airplay.devices.to_a
      end

      def get(device_number)
        return nil unless exist?(device_number)
        Airplay[devices.at(device_number).name]
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
