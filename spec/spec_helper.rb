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

Airplay.devices.add('Dummy Device', 'dummy.appletv.local:7000')

def dummy_device
  Airplay['Dummy Device']
end

require 'airplayer'
