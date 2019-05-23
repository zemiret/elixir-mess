defmodule ParserCommon do
  @moduledoc false

  @respath "res"

  def benchmark(parse_fn) do
    time_small = fn -> parse_fn.("inbox_small") end |> :timer.tc |> elem(0)
    time_big = fn -> parse_fn.("inbox_big") end |> :timer.tc |> elem(0)
    time_very_big = fn -> parse_fn.("inbox_fake_very_big") end |> :timer.tc |> elem(0)

    {time_small, time_big, time_very_big}
  end

  def extract_filepaths(dirpath) do
    Path.wildcard(dirpath <> "/**/message_*.json")
  end

  def parse_message(messageMap) do
    %Message{
      sender: Map.get(messageMap, "sender_name"), 
      content: Map.get(messageMap, "content"),
      timestamp: Map.get(messageMap, "timestamp_ms") 
    }
  end

  def respath do
    @respath
  end
end