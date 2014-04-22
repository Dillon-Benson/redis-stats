require 'spec_helper'

describe "CLI" do
  it "should output basic stats" do
    command = RedisStats::Command.new(DATA_ARG)
    RedisStats::Session.clear!
    RedisStats::Session << command
    RedisStats::Session << command
    RedisStats::Session << command
    str = <<-EOS
Most used data structure: List
Commands issued: 3
Latest command: 1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Foo\" \"Bar\" \"Baz\"


      EOS

    output = capture_stdout { puts str }
    output.should == "Most used data structure: List\nCommands issued: 3\nLatest command: 1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Foo\" \"Bar\" \"Baz\"\n\n\n"
  end
end