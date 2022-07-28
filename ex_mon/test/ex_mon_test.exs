defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "resturns a player" do

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Arthur"
      }

      assert expected_response == ExMon.create_player("Arthur", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "when the is started, resturns a message" do
      player = Player.build("Arthur", :kick, :punch, :heal)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "Arthur"
    end
  end

  describe "make_move/1" do

    setup do
      player = Player.build("Arthur", :kick, :punch, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end
    test "when the move is valid, make the and the computer makes a move" do

      messages =
        capture_io(fn ->
          ExMon.make_move(:kick)
        end)

      assert messages =~ "The Player attacked the Computer"

    end

    test "when the move is invalid, make the and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid Move: wrong"
    end
  end
end
