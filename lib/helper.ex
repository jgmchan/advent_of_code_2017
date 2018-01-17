defmodule Helper do
  import ExProf.Macro

  def time(fun) do
    {time, result} = :timer.tc(fun)
    {time / 1_000_000, result}
  end

  def do_profile(fun) do
    profile do
      fun.()
    end

    nil
  end
end
