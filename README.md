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

## Running
```
iex -S mix
```

This command starts an interactive session with your files compiled
so you can acces them in REPL.

## Where are we using flow?

* Extracting data from each file.
    - [x] For each message filepath extract it into some internal representation

* Extracting statistics.
    - [x] Total number of exchanged messages
    - [x] Messages exchanged per day
    - [x] Bags of words. Which words do we use most frequently
    - [x] With who did we exchange the most messages

* Search for specific word usage.
    - [x] How many times have someone (especially we) used it together with windowing in 1000 counter window
