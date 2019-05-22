defmodule MessFlow do
  @moduledoc false

  @doc """
  The total count of messages you've exchanged
  """
  def messages_total(conversations) do
    # TODO: This ain't working yet!

    conversations
    |> Flow.from_enumerable
    |> Flow.map(fn c -> length(c.messages) end)
    |> Flow.partition
    |> Flow.reduce(fn -> 0 end, fn acc, cur -> acc + cur end)
  end

  @doc """
  The total count of messages you've exchanged partitioned by day
  """
  def messages_per_day(conversations) do
    
  end 

  @doc """
  Words from your messages sorted by their frequency of usage 
  """
  def words_by_frequency(conversations) do
    
  end

  @doc """
  Takes n people with whom you have exchanged the most messages 
  """
  def most_liked(conversations, n \\ 5) do
    # TODO: Hmm. This is much slower than the enum version

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
