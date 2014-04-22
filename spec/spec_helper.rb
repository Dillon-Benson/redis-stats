$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'redis-stats'

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
