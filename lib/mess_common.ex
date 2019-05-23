defmodule MessCommon do
  def date_from_timestamp(timestamp) do
    {:ok, dt} = DateTime.from_unix(timestamp, :millisecond)
    {dt.year, dt.month, dt.day}
  end
end