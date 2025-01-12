defmodule SimpleMmoWeb.GameLive.LoginForm do
  use SimpleMmoWeb, :live_component
  
  alias SimpleMmo.Game

  @impl true
  def render(assigns) do
    ~H"""
    <div>

      <.header>
        Please Choose a Character Name
        <:subtitle>It will be the name displayed to other player.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="player-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Player</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{player: player} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Game.change_player(player))
     end)}
  end

  @impl true
  def handle_event("validate", %{"player" => player_params}, socket) do
    changeset = Game.change_player(socket.assigns.player, player_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end
  
  def handle_event("save", %{"player" => player_params}, socket) do
    IO.inspect(player_params)
    socket = assign(socket, :player, player_params)
    {:noreply,
     socket
     |> put_flash(:info, "Player created successfully")
     |> push_patch(to: socket.assigns.patch)}
  end
end
