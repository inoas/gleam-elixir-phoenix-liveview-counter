defmodule MeetupWeb.Game do
  use Phoenix.LiveView, layout: {MeetupWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, gleam_store: :gleam_app.create_store(1))}
  end

  def handle_event(action, _data, socket) do
    actions = Enum.map(:gleam_app.actions(), &Atom.to_string(&1))

    if action in actions do
      gleam_store = :gleam_app.update(socket.assigns.gleam_store, String.to_atom(action))
      {:noreply, assign(socket, gleam_store: gleam_store)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-16 text-2xl">
      <h2 class="text-center pb-3 select-none">Counter</h2>
      <div class="mx-auto rounded-full bg-gradient-to-b from-indigo-500 via-purple-800 to-pink-500 w-32 h-32 flex items-center justify-center text-white font-bold text-3xl drop-shadow-md select-none [text-shadow:0_4px_8px_rgba(0,0,0,0.33)]">
        <%= :gleam_app.get_counter_value(@gleam_store) %>
      </div>
      <div class="flex gap-2 justify-center pt-4">
        <button href="#" phx-click="decrement" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner">
          -
        </button>
        <button href="#" phx-click="increment" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner">
          +
        </button>
      </div>
    </div>
    """
  end
end
