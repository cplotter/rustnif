defmodule Profiler do
  import ExProf.Macro

  @doc "analyze with profile macro"
  def rust_analyze do
    list = Enum.to_list(0..10000)

    profile do
      Enum.each(list, fn x ->
        y = Enum.random(0..x)
        Rustnif.NifTest.add(x, y)
      end)

      IO.puts("profiling\n")
    end
  end

  def add(x, y) do
    x + y
  end

  def native_analyze do
    list = Enum.to_list(0..10000)

    profile do
      Enum.each(list, fn x ->
        y = Enum.random(0..x)
        add(x, y)
      end)

      IO.puts("profiling\n")
    end
  end

  @doc "get analysis records and sum them up"
  def run do
    {records, :ok} = rust_analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect("total = #{total_percent}")

    {records, :ok} = native_analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect("total = #{total_percent}")
  end
end
