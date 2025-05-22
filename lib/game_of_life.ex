defmodule GameOfLife do
  @moduledoc """
  Documentation for `GameOfLife`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GameOfLife.hello("Joe")
      "Hello, Joe!"

  """
  def hello(name) do
    "Hello, #{name}!"
  end

  def next_cell_state(current_state, count_of_living_neighbours) do
    next_state =
      case {current_state, count_of_living_neighbours} do
        {:live, 2} -> :live
        {:live, 3} -> :live
        {:dead, 3} -> :live
        _ -> :dead
      end

    next_state
  end
end
