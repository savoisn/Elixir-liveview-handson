defmodule SimpleMmo.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleMmo.Game` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SimpleMmo.Game.create_player()

    player
  end
end
