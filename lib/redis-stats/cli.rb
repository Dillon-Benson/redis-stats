module RedisStats
  class CLI
    class << self
      def run
        x = gets
        while x = gets
          RedisStats::Session << RedisStats::Command.new(x)
          puts "Most used data structure: #{RedisStats::Session.most_used_data_structure}"
          puts "Commands issued: #{RedisStats::Session.commands_processed}"
          puts "Latest command: #{RedisStats::Session.latest_command.received_data}\n\n\n"
        end
      end
    end
  end
end
