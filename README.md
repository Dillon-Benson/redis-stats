# redis-stats

Get stats about the commands sent to a Redis instance

(Currently only supports OS X)

## Usage

  redis-cli monitor | ./bin/redis-stats
    
Credit to [redis-faina](https://github.com/Instagram/redis-faina) for the above method

You should see several facts about all the commands:

    Most used data structure: List
    Commands issued: 2100
    Latest command: "1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Foo\" \"Bar\" \"Baz\""

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request


Don't forget the tests!!!

    rake

Installing dependencies

    bundle install
