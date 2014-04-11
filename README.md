# redis-stats

Get stats about the commands sent to a Redis instance

Do:

	redis-cli monitor | ./bin/redis-stats
    
Credit to [redis-faina](https://github.com/Instagram/redis-faina) for the above method

You should see several facts about all the commands:

	Most used data structure: List
    Commands issued: 2100
    Latest command: "1397170134.089152 [0 127.0.0.1:51958] \"LPUSH\" \"names\" \"Foo\" \"Bar\" \"Baz\""
    