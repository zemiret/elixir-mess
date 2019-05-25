defmodule Benchmark do
  @moduledoc false

  @datasets ["inbox_small", "inbox_big", "inbox_very_big"]
  @reps 10
  @timeres :millisecond

  def benchmark(f) do
    f |> :timer.tc |> elem(0)
  end

  def benchmark_all do
    benchmark_loading()
    benchmark_msg_counting()
    benchmark_most_frequent()
  end

  def benchmark_loading do
    # loading enum
    Enum.each(@datasets, fn dataset ->
      benchmark_to_file("benchmarks/loading_enum-#{dataset}", fn ->
        JSONParserEnum.parse(dataset)
      end)
    end)
    # loading flow
    Enum.each(@datasets, fn dataset ->
      benchmark_to_file("benchmarks/loading_flow-#{dataset}", fn ->
        JSONParserFlow.parse(dataset)
      end)
    end)
  end

  def benchmark_msg_counting do
    # enum
    Enum.each(@datasets, fn dataset ->
      conversations = JSONParserEnum.parse(dataset)

      benchmark_to_file("benchmarks/total_enum-#{dataset}", fn ->
        MessEnum.messages_total(conversations)
      end)
    end)
    # flow
    Enum.each(@datasets, fn dataset ->
      conversations = JSONParserEnum.parse(dataset)

      benchmark_to_file("benchmarks/total_flow-#{dataset}", fn ->
        MessFlow.messages_total(conversations)
      end)
    end)
  end

  def benchmark_most_frequent do
    # enum
    Enum.each(@datasets, fn dataset ->
      conversations = JSONParserEnum.parse(dataset)

      benchmark_to_file("benchmarks/frequent_enum-#{dataset}", fn ->
        MessEnum.most_frequent(conversations, 100)
      end)
    end)
    # flow
    Enum.each(@datasets, fn dataset ->
      conversations = JSONParserEnum.parse(dataset)

      benchmark_to_file("benchmarks/frequent_flow-#{dataset}", fn ->
        MessFlow.most_frequent(conversations, 100)
      end)
    end)
  end

  defp benchmark_to_file(filepath, f) do
      file = File.open!(filepath, [:write])
      Enum.each(1..@reps, fn i ->
        start_time = :os.system_time(@timeres) 
        f.()
        end_time = :os.system_time(@timeres) 

        IO.write(file, "#{i}\t#{end_time - start_time}\n")
      end)
  end
end