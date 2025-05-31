defmodule Main do
  import GameOfLife

  def start() do
    IO.puts("Hello game of life\n")
    initial_world = [{3, 4}, {4, 4}, {5, 4}]
    spawn(fn -> loop(initial_world) end)
    :timer.sleep(:infinity)
    :ok
  end

  def loop(world) do
    world = tick(world)
    render(world)
    :timer.sleep(1_000)
    loop(world)
  end
end

# Main.start()
