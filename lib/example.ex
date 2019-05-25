defmodule Example do
  def run do
    IO.puts("Scrubbing yer treasures.")
    conversations = JSONParserFlow.parse("inbox_big")
    IO.inspect(length(conversations))
   
    IO.puts("Gimme total:")
    IO.gets("<any key>\n")
    IO.inspect(MessFlow.messages_total(conversations))
    IO.inspect(MessEnum.messages_total(conversations))

    IO.puts("Gimme per day:")
    IO.gets("<any key>\n")
    IO.inspect(MessFlow.messages_per_day(conversations))
    IO.inspect(MessEnum.messages_per_day(conversations))

    IO.puts("Gimme my most frequent:")
    IO.gets("<any key>\n")
    IO.inspect(MessFlow.most_frequent(conversations, 20, "Antek Mleczko"))
    IO.inspect(MessEnum.most_frequent(conversations, 20, "Antek Mleczko"))

    IO.puts("Gimme me most liked hearties:")
    IO.gets("<any key>")
    IO.inspect(MessFlow.most_liked(conversations, 3))
    IO.inspect(MessEnum.most_liked(conversations, 3))

    :ok
  end

end