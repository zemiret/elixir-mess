defmodule Benchmark do
  @moduledoc false

  def benchmark(f) do
    f |> :timer.tc |> elem(0)
  end
end