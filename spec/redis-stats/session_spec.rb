require "spec_helper"

describe "Session" do
	it "should keep track of how many commands have been processed" do
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session.commands_processed.should == 3
	end

	it "should raise an ArgumentError when trying to add something that's not a Command object" do
		expect { RedisStats::Session << "foobar" }.to raise_error(ArgumentError)
	end

	it "should clear all processed command in a session" do
		10.times do
			RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		end
		RedisStats::Session.clear!
		RedisStats::Session.all_processed_commands.length.should == 0
	end

	it "should contain an Array of all commands that were processed" do
		3.times do
			RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		end
		RedisStats::Session.all_processed_commands.length.should == 3
	end

	it "should sort all commands by data structure" do
		list_commands = RedisStats::Session.processed_commands("List")
		list_commands[0].data_structure.should == "List"
	end

	it "should find the most frequently used data structure" do
		RedisStats::Session.clear!
		RedisStats::Session << RedisStats::Command.new("1397170134.089152 [0 127.0.0.1:51958] \"SET\" \"mykey\" \"Ruby\"")
		RedisStats::Session << RedisStats::Command.new("1397170134.089152 [0 127.0.0.1:51958] \"SET\" \"mykey\" \"Ruby\"")
		RedisStats::Session << RedisStats::Command.new("1397170134.089152 [0 127.0.0.1:51958] \"SET\" \"mykey\" \"Ruby\"")
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session.most_used_data_structure.should == "String"
	end

	it "should say what the latest command Entered was" do
		RedisStats::Session.clear!
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session << RedisStats::Command.new(DATA_ARG)
		RedisStats::Session.latest_command.data_structure.should == "List"
	end
end