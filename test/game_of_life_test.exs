defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "greets" do
    assert GameOfLife.hello("Joe") == "Hello, Joe!"
  end
end
