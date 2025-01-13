defmodule SimpleMmo.Worker.Enemy do
  use GenServer

  alias Phoenix.PubSub

  def init(init_arg) do
    PubSub.subscribe(SimpleMmo.PubSub, "game")
    {:ok, init_arg}
  end

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, %{hp: init_arg}, name: __MODULE__)
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
    rep = GenServer.call(__MODULE__, {:current_hp})
    IO.inspect(rep)
  end


end
