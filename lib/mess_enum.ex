defmodule MessEnum do
  @moduledoc false

  @doc """
  The total count of messages you've exchanged
  """
  def messages_total(conversations) do
    
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
    conversations
    |> Enum.map(fn conversation -> 
      %{participants: conversation.participants, count: length(conversation.messages)}
    end)
    |> Enum.sort(fn c1, c2 -> Map.get(c1, :count) > Map.get(c2, :count) end)
    |> Enum.map(fn c -> 
      participants = Map.get(c, :participants)
      {
        Map.get(c, :count),
        participants |> Enum.map(fn p -> Map.get(p, "name") end)
      }
    end)
    |> Enum.take(n)
  end
end
