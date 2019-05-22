defmodule JSONParser do
  @moduledoc false

  @respath "res"

  def testprint do
#    extract_filepaths() |>
#    Enum.each (fn x -> IO.puts(x) end)
#    msg = %Message{sender: "Maciejka", content: "WUt?", timestamp: 1230}
#
#    msg |> IO.inspect

    [file | _] = extract_filepaths()

    decoded = File.read!(file)
    |> Poison.decode! 

    Map.get(decoded, "is_still_participant")
  end

  defp extract_filepaths do
    Path.wildcard(@respath <> "/**/message_*.json")
  end

  defp parse_conversation do

  end

  defp parse_message do

  end
end
