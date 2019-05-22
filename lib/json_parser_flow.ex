defmodule JSONParserFlow do
  @moduledoc false

  @respath "res"

  def testprint do
    parse() |> IO.inspect
  end

  def parse do
    extract_filepaths()
    |> Flow.from_enumerable
    |> Flow.map(fn filepath ->
      File.read!(filepath) |> Poison.decode! |> parse_conversation 
    end)
    |> Enum.to_list
  end

  def benchmark do
    fn -> parse() end |> :timer.tc |> elem(0)
  end

  defp extract_filepaths do
    Path.wildcard(@respath <> "/**/message_*.json")
  end

  defp parse_conversation(contentMap) do
    messages = Map.get(contentMap, "messages")
    |> Flow.from_enumerable
    |> Flow.filter(&(String.downcase(Map.get(&1, "type")) == "generic"))
    |> Flow.map(&(parse_message/1))
    |> Enum.to_list

    %Conversation{
      participants: Map.get(contentMap, "participants"),
      title: Map.get(contentMap, "title"),
      messages: messages
    }
  end

  defp parse_message(messageMap) do
    %Message{
      sender: Map.get(messageMap, "sender_name"), 
      content: Map.get(messageMap, "content"),
      timestamp: Map.get(messageMap, "timestamp_ms") 
    }
  end
end
