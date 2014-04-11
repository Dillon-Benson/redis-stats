module RedisStats
	class Command
		attr_reader :received_data			# "1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Dillon\" \"Nelson\" \"Kristal\""

		def initialize(data)
			raise ArgumentError, "A Command object must be initialized with a String object" if data.class != String
			@received_data = data
		end

		def data_structure
			data_structures = {"K" => "Key", "H" => "Hash", "L" => "List"}
			key = remove_quotes(@received_data.split[3])[0]
			return "String" unless data_structures.has_key?(key)
			data_structures[key]
		end

		def arg_count
			arg_count = @received_data.split.length - 5
		end

		def args
			received_data.split[5..-1]
		end

		def key
			received_data.split[4]
		end

		private

		def remove_quotes(str)
			str.delete("\"")
		end
	end
end