defmodule MeetupWeb.Game do
  use Phoenix.LiveView, layout: {MeetupWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    # non-OTP part
    gleam_store = :gleam_app.create_store(2)
    socket = assign(socket, gleam_store: gleam_store)
    # OTP part
    {:sender, gleam_otp_pid, details} = :gleam_app.start_otp(gleam_store)
    IO.inspect(details)
    # Send test #1
    send(gleam_otp_pid, {:gleam_otp, :increment})
    socket = assign(socket, gleam_otp_pid: gleam_otp_pid)
    # Send test #2
    send(socket.assigns.gleam_otp_pid, {:gleam_otp, :increment})
    {:ok, socket}
  end

  def handle_event(action, _data, socket) do
    actions = Enum.map(:gleam_app.actions(), &Atom.to_string(&1))

    if action in actions do
      # non-OTP part
      action = String.to_atom(action)
      gleam_store = :gleam_app.update(socket.assigns.gleam_store, action)
      # OTP part
      send(socket.assigns.gleam_otp_pid, {:gleam_otp, action})
      {:noreply, assign(socket, gleam_store: gleam_store)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-16 text-2xl">
      <h2 class="text-center pb-3 select-none">Counter</h2>
      <div class="mx-auto rounded-full bg-gradient-to-b from-indigo-500 via-purple-800 to-pink-500 w-32 h-32 flex items-center justify-center text-white font-bold text-3xl drop-shadow-md select-none [text-shadow:0_2px_4px_rgba(0,0,0,.67)] border-2  border border-indigo-400">
        <%= :gleam_app.get_counter_value(@gleam_store) %>
      </div>
      <div class="flex gap-2 justify-center pt-4">
        <button href="#" phx-click="decrement" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner border border-indigo-600">
          -
        </button>
        <button href="#" phx-click="increment" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner border border-indigo-600">
          +
        </button>
      </div>
    </div>
    """
  end
end
