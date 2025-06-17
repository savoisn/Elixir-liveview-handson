defmodule SimpleMmo.Repo.Migrations.Add_player_hp do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :hp, :integer, default: 0
    end
  end
end
