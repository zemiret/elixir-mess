defmodule JSONParserFlow do
  @moduledoc false

  def parse(dir) do
    ParserCommon.extract_filepaths(ParserCommon.respath <> "/" <> dir)
    |> Flow.from_enumerable
    |> Flow.map(fn filepath ->
      File.read!(filepath) |> Poison.decode! |> parse_conversation 
    end)
    |> Enum.to_list
  end

  defp parse_conversation(contentMap) do
    messages = Map.get(contentMap, "messages")
    |> Flow.from_enumerable
    |> Flow.filter(&(String.downcase(Map.get(&1, "type")) == "generic"))
    |> Flow.map(&(ParserCommon.parse_message/1))
    |> Enum.to_list

    %Conversation{
      participants: Map.get(contentMap, "participants"),
      title: Map.get(contentMap, "title"),
      messages: messages
    }
  end
end
