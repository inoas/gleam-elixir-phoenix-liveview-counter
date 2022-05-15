defmodule MeetupWeb.Game do
  use Phoenix.LiveView, layout: {MeetupWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    socket = assign(socket, gleam_store: :gleam_app.create_store(2))
    socket = assign(socket, gleam_process: :gleam_app.start_process())

    # receive do
    #   {tag, msg} -> IO.inspect({tag, msg})
    # end

    {:ok, socket}
  end

  def handle_event(action, params, socket) do
    expected_actions = Enum.map(:gleam_app.actions(), &Atom.to_string(&1))

    if action in expected_actions do
      action = String.to_atom(action)
      do_handle_event(action, params, socket)
    end

    # Otherwise: Let it crash!
  end

  def do_handle_event(:set_step, %{"step" => step} = _params, socket) do
    step =
      try do
        step |> String.to_integer()
      rescue
        _ -> 1
      end

    gleam_store = :gleam_app.update(socket.assigns.gleam_store, :set_step, {:some, step})
    {:noreply, assign(socket, gleam_store: gleam_store)}
  end

  def do_handle_event(action, _params, socket) do
    # non-OTP part
    gleam_store = :gleam_app.update(socket.assigns.gleam_store, action, :none)
    # OTP part
    :gleam_app.send_message(socket.assigns.gleam_process, {action, :none})
    {:noreply, assign(socket, gleam_store: gleam_store)}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-16 pb-24 text-2xl">
      <h2 class="text-center pb-3 select-none [text-shadow:0_2px_3px_rgba(0,0,0,.2)] font-medium">Counter</h2>
      <div class="mx-auto rounded-full bg-gradient-to-b from-indigo-500 via-purple-800 to-pink-500 w-44 h-44 flex items-center justify-center text-white font-bold text-3xl drop-shadow-md select-none [text-shadow:0_2px_4px_rgba(0,0,0,.67)] border-2 border border-indigo-400">
        <%= :gleam_app.get_counter_value(@gleam_store) %>
      </div>
      <div class="flex gap-2 justify-center pt-4">
        <button phx-click="decrement" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner border border-indigo-600">
          -
        </button>
        <form phx-change="set_step">
          <style type="text/css">
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
            }
            input[type=number] {
    					caret-color: transparent;
              -moz-appearance: textfield;
            }
          </style>
          <input name="step" value={:gleam_app.get_counter_step(@gleam_store)} phx-debounce="blur" type="number" min="1" max="99" step="1" inputmode="numeric" pattern="[1-9][0-9]" autofocus="autofocus" class="block rounded w-14 h-14 font-xl border border-indigo-600 text-center focus:outline-none focus:ring focus:ring-violet-300"/>
        </form>
        <button phx-click="increment" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner border border-indigo-600">
          +
        </button>
      </div>
    </div>
    """
  end
end
