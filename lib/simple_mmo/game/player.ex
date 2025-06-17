defmodule SimpleMmo.Game.Player do

@moduledoc """
Players schema.
"""
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    field :hp, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
