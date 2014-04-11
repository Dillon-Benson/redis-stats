require 'spec_helper'

DATA_ARG = "1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Dillon\" \"Nelson\" \"Kristal\"".freeze

describe "Command" do
	it "should raise an ArgumentError if not created with a String object" do
		expect { RedisStats::Command.new(1) }.to raise_error(ArgumentError)
	end

	it "should assign the data argument to received_data instance variable when created" do
		command = RedisStats::Command.new(DATA_ARG)
		data = command.received_data
		data.should == DATA_ARG
	end

	it "should say which data structure in Redis was used with the command" do
		data_structures = %w(Key String Hash List)		# 4 data_structures just for testing
		command = RedisStats::Command.new(DATA_ARG)
		data_structure = command.data_structure
		data_structures.include?(data_structure).should == true
	end

	it "should be able to detect if a Redis String was used as a data structure" do
		command = RedisStats::Command.new("1397170134.089152 [0 127.0.0.1:51958] GET name \"Dillon\"")
		data_structure = command.data_structure
		data_structure.should == "String"
	end

	it "should say how many arguments were issued in the command" do
		command = RedisStats::Command.new(DATA_ARG)
		arg_count = command.arg_count
		arg_count.should == 3
	end

	it "should give back the args given to it" do
		command = RedisStats::Command.new(DATA_ARG)
		args = command.args
		args[0].should == "\"Dillon\""
	end

	it "should give back the Key used in the command" do
		command = RedisStats::Command.new(DATA_ARG)
		key = command.key
		key.should == "\"names\""
	end
end