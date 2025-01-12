defmodule SimpleMmoWeb.GameLive.Index do
  use SimpleMmoWeb, :live_view

  alias SimpleMmo.Game.Player


  @impl true
  @spec mount(any(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    socket = assign(socket, :player, %Player{})
    {:ok, stream(socket, :help, [])}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def handle_info(_, _, socket) do
    {:noreply, stream(socket, :help, [])}
  end
end
