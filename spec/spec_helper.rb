require 'coveralls'
Coveralls.wear!

require 'stringio'
RSpec.configure do |c|
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval "$#{stream} = #{stream.upcase}"
    end
    result
  end
end


require 'airplay'
Airplay.configure do |c|
  c.autodiscover = false
end

# https://github.com/elcuervo/airplay/blob/master/lib/airplay/device.rb
# https://github.com/elcuervo/airplay/blob/master/lib/airplay/device/info.rb
def double_device
  device = Airplay::Device.new(name: 'Double Device', address: 'double.appletv.local:7000')
  allow(device).to receive('ip').and_return('127.0.0.1')
  allow(device).to receive('server_info').and_return({
    'model'      => 'AppleTV2,1',
    'os_version' => '11B554a',
    'width'      => '1280',
    'height'     => '720'
  })
  device
end

require 'airplayer'
