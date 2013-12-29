require 'coveralls'
Coveralls.wear!

require 'airplayer'
require 'airplay'

Airplay.configure do |c|
  c.autodiscover = false
end

Airplay.devices.add('Dummy Device', 'dummy.appletv.local:7000')

def dummy_device
  Airplay['Dummy Device']
end
