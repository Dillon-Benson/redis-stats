$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'redis-stats'
require 'stringio'

DATA_ARG = "1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Foo\" \"Bar\" \"Baz\"".freeze

class Toggle
  class << self
    def kill_redis
      if self.running?
        pid = Integer(`pgrep redis-server`)
        system("kill -9 #{pid}")
      end
    end
  end

  private
  def self.running?
    system('pgrep redis-server')
  end
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
