# Mess

Messenger statistics.

## Setup 

1. Download your messenger chat history. You can follow  [this](https://www.zapptales.com/en/download-facebook-messenger-chat-history-how-to/). I suggest you download only last year or so, otherwise it takes ages to complete your file creation.
2. Move `inbox` folder from extracted zip archive to `<this-repo>/res` (`res` folder is ignored in this repo not to exhibit your personal data)
3. 
```elixir
# Install dependencies
mix deps.get
```

4. Check if it's compiling: `mix test`

## Where can we use flow?

* Extracting data from each file.
    * For each message filepath extract its statistics into some internal representation

* Extracting statistics. What should we extract?
    * Total number of exchanged messages
    * Messages exchanged per day
    * Bags of words. Which words do we use most frequently
    * With who did we exchange the most messages

* Search for specific word usage.
    * How many times have we used it
    * In messages with who have we used it and how many times
