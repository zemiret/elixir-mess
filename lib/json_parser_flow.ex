defmodule JSONParserFlow do
  @moduledoc false

  @respath "res"

  def testprint do
    conversations = extract_filepaths()
    |> Enum.map(fn filepath -> 
      File.read!(filepath) |> Poison.decode!
    end)
    |> Enum.map(&(parse_conversation/1))

    IO.inspect(conversations)
  end

  defp extract_filepaths do
    Path.wildcard(@respath <> "/**/message_*.json")
  end

  defp parse_conversation(contentMap) do
    messages = Map.get(contentMap, "messages")
    |> Enum.filter(&(String.downcase(Map.get(&1, "type")) == "generic"))
    |> Enum.map(&(parse_message/1))

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
