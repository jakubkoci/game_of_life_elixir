defmodule Main do
  import GameOfLife

  def start() do
    IO.puts("Hello game of life\n")
    initial_world = [{1, 2}, {2, 2}, {3, 2}]
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

  def render(world) do
    for y <- 0..5 do
      line =
        Enum.to_list(0..5)
        |> Enum.map(fn x ->
          cell = {x, y}

          case is_alive(world, cell) do
            true -> "x "
            _ -> "o "
          end
        end)

      IO.puts(line)
    end

    IO.puts("\n")
  end
end
