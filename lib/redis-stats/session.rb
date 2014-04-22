module RedisStats
  class Session
    @@processed_commands = Array.new

    class << self
      def commands_processed
        @@processed_commands.length
      end

      def <<(command)
        raise ArgumentError, "Must be given a Command object" if command.class != Command
        @@processed_commands << command
      end

      def all_processed_commands
        @@processed_commands
      end

      def processed_commands(data_structure)
        data_structures = %w(Key String Hash List)
        raise ArgumentError, "Must be a 'Key', 'String', 'Hash', or 'List'" unless data_structures.include?(data_structure)
        @@processed_commands.select{ |command| command.data_structure == data_structure }
      end

      def latest_command
        @@processed_commands[-1]
      end

      def clear!
        @@processed_commands = Array.new
      end

      def most_used_data_structure
        key_length = @@processed_commands.select { |command| command.data_structure == "Key" }.length
        string_length = @@processed_commands.select { |command| command.data_structure == "String" }.length
        hash_length = @@processed_commands.select { |command| command.data_structure == "Hash"}.length
        list_length = @@processed_commands.select { |command| command.data_structure == "List"}.length

        lengths = [key_length, string_length, hash_length, list_length]

        case lengths.max
        when key_length
          return "Key"
        when string_length
          return "String"
        when hash_length
          return "Hash"
        when list_length 
          return "List"
        end
      end
    end
  end
end