defmodule Search do
  @moduledoc false

  def search(conversations, word, by \\ nil, in_conversation \\ nil, window_size \\ 1000) do
    word = String.downcase(word)

    freq_windows = conversations
    |> Flow.from_enumerable
    |> Flow.filter(fn c ->
      (in_conversation == nil or c.title == in_conversation)
    end)
    |> Flow.flat_map(fn c -> c.messages end)
    |> Flow.filter(fn m ->
      m.content != nil and
      (by == nil or m.sender == by)
    end)
    |> Flow.flat_map(fn m -> String.split(m.content, [" ", "\t", "\n", "\r\n", "\n\r"]) end)
    |> Flow.partition(window: Flow.Window.count(window_size), stages: 1)
    |> Flow.reduce(fn -> 0 end, fn w, acc -> 
      if String.downcase(w) == word, do: acc + 1, else: acc
    end)
    |> Flow.emit(:state)
    |> Enum.to_list

    freq = freq_windows |> Enum.sum

    {word, freq_windows, freq}
  end
end