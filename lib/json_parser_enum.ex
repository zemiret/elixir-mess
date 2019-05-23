defmodule JSONParserEnum do
  @moduledoc false

  def parse(dir) do
    ParserCommon.extract_filepaths(ParserCommon.respath <> "/" <> dir)
    |> Enum.map(fn filepath -> 
      File.read!(filepath) |> Poison.decode! |> parse_conversation
    end)
  end

  defp parse_conversation(contentMap) do
    messages = Map.get(contentMap, "messages")
    |> Enum.filter(&(String.downcase(Map.get(&1, "type")) == "generic"))
    |> Enum.map(&(ParserCommon.parse_message/1))

    %Conversation{
      participants: Map.get(contentMap, "participants"),
      title: Map.get(contentMap, "title"),
      messages: messages
    }
  end
end
