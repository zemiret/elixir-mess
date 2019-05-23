defmodule MessFlow do
  @moduledoc false

  @doc """
  The total count of messages you've exchanged
  """
  def messages_total(conversations) do
    conversations
    |> Flow.from_enumerable
    |> Flow.partition
    |> Flow.map(fn c -> length(c.messages) end)
    |> Flow.reduce(fn -> 0 end, fn acc, cur -> acc + cur end)
    |> Flow.emit(:state)
    |> Enum.sum
  end

  @doc """
  The total count of messages you've exchanged partitioned by day
  """
  def messages_per_day(conversations) do
    conversations
    |> Flow.from_enumerable
    |> Flow.flat_map(fn c -> c.messages end)
    |> Flow.reduce(fn -> %{} end, fn msg, acc -> 
      datetime = MessCommon.date_from_timestamp(msg.timestamp)
      
      case Map.has_key?(acc, datetime) do
        false ->
          Map.put(acc, datetime, [msg])
        true ->
          msglist = Map.get(acc, datetime) 
          msglist = [msg | msglist]
          Map.put(acc, datetime, msglist)
      end
    end)
    |> Enum.to_list
    |> Enum.sort(fn {{y1, m1, d1}, _}, {{y2, m2, d2}, _} -> 
      {:ok, dt1} = NaiveDateTime.new(y1, m1, d1, 0, 0, 0)
      {:ok, dt2} = NaiveDateTime.new(y2, m2, d2, 0, 0, 0)
      NaiveDateTime.compare(dt1, dt2) == :lt
    end)
  end 

  @doc """
  Words from your messages sorted by their frequency of usage by the given participant 
  """
  def most_frequent(conversations, n, by \\ nil) do
    conversations
    |> Flow.from_enumerable
    |> Flow.flat_map(fn c -> c.messages end)
    |> Flow.filter(fn m ->
      m.content != nil and
      (by == nil or m.sender == by)
    end)
    |> Flow.flat_map(fn m -> String.split(m.content, [" ", "\t", "\n", "\r\n", "\n\r"]) end)
    |> Flow.map(fn w -> String.downcase(w) end)
    |> Flow.partition
    |> Flow.reduce(fn -> %{} end, fn word, acc -> 
      case Map.has_key?(acc, word) do
        false ->
          Map.put(acc, word, 1)
        true ->
          Map.put(acc, word, Map.get(acc, word) + 1)
      end
    end)
    |> Flow.take_sort(n, fn {_, freq1}, {_, freq2} ->
      freq1 > freq2
    end)
    |> Enum.to_list
  end

  @doc """
  Takes n people with whom you have exchanged the most messages 
  """
  def most_liked(conversations, n \\ 5) do
    [topn] = conversations
    |> Flow.from_enumerable
    |> Flow.map(fn conversation -> 
      %{participants: conversation.participants, count: length(conversation.messages)}
    end)
    |> Flow.group_by(fn conversation -> Map.get(conversation, :participants) end) 
    |> Flow.take_sort(n, fn {_, count1}, {_, count2} -> count1 > count2 end)
    |> Enum.to_list

    topn |>
    Enum.map(fn {p, [c]} ->
      {
        p |> Enum.map(&(Map.get(&1, "name"))),
        Map.get(c, :count)
      } 
    end)
  end
end
