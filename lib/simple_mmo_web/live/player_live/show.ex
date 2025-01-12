defmodule SimpleMmoWeb.PlayerLive.Show do
  use SimpleMmoWeb, :live_view

  alias SimpleMmo.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:player, Game.get_player!(id))}
  end

  defp page_title(:show), do: "Show Player"
  defp page_title(:edit), do: "Edit Player"
end
