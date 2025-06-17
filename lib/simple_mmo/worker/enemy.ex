defmodule SimpleMmo.Worker.Enemy do

  @attack_rate 2000
  @attack_damage 50

  use GenServer

  alias Phoenix.PubSub

  def init(init_arg) do
    PubSub.subscribe(SimpleMmo.PubSub, "game")
    Process.send_after(self(), :attack_players, @attack_rate)

    {:ok, init_arg}
  end

  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, %{hp: init_arg}, name: __MODULE__)
  end

  def handle_info(:attack_players, state) do
    IO.inspect("attacking players")
    PubSub.broadcast_from(SimpleMmo.PubSub, self(), "game", {:dragon_attack, %{damage: @attack_damage}})

    Process.send_after(self(), :attack_players, @attack_rate)
    {:noreply, state}
  end

  def handle_info({:attack, %{damage: damage}}, %{hp: hp}) do
    IO.inspect(damage)
    IO.inspect(hp)
    hp = hp - damage
    PubSub.broadcast_from(SimpleMmo.PubSub, self(), "game", {:dragon_health, %{hp: hp}})
    {:noreply, %{hp: hp}}
  end

  def handle_call({:current_hp}, _from, state) do
    {:reply, state, state}
  end

  def get_current_hp() do
    GenServer.call(__MODULE__, {:current_hp})
  end


end
