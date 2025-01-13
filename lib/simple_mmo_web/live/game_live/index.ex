defmodule SimpleMmoWeb.GameLive.Index do
  use SimpleMmoWeb, :live_view

  alias Phoenix.PubSub

  alias SimpleMmo.Game.Player
  alias SimpleMmo.Worker.Enemy

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :player, %Player{})
            |> assign(:monster_health, Enemy.get_current_hp().hp)
    {:ok, stream(socket, :help, [])}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def handle_info(_, _, socket) do
    {:noreply, stream(socket, :help, [])}
  end

  @impl true
  def handle_event("attack", _value, socket) do
    IO.inspect(socket.assigns)
    topicname = socket.assigns.topicname
    # player = socket.assigns.player
    PubSub.broadcast_from(SimpleMmo.PubSub, self(), topicname, {:attack, %{damage: 10}})
    {:noreply, socket}
  end

  def handle_info({:attack_dragon, attack}, socket) do
    IO.inspect("Attack in done! for " <> to_string(attack.damage))
    {:noreply, socket}
  end


  @impl true
  def handle_info({SimpleMmoWeb.GameLive.LoginForm, {:saved, player}}, socket) do
    topic = "game"

    socket =
      socket
      |> assign(:player, %Player{name: player["name"]})
      |> assign(:topicname, topic)

    PubSub.subscribe(SimpleMmo.PubSub, topic)
    {:noreply, socket}
  end

  def handle_info({:dragon_health, %{hp: hp}}, socket) do
    IO.inspect("dragon health! "<> to_string(hp))

    socket = assign(socket, :monster_health, hp)
    {:noreply, socket}
  end

  def handle_info(hello, socket) do
    IO.inspect(hello)
    IO.inspect("Attack in done!")
    {:noreply, socket}
  end
end
