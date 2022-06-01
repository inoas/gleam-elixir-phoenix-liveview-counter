defmodule MeetupWeb.Game do
  use Phoenix.LiveView, layout: {MeetupWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    gleam_store = :gleam_app.create_store(2)
    {:ok, assign(socket, gleam_store: gleam_store)}
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
      case Integer.parse(step) do
        :error -> 1
        {step, _rest} -> step
      end

    gleam_store = :gleam_app.update(socket.assigns.gleam_store, :set_step, {:some, step})
    {:noreply, assign(socket, gleam_store: gleam_store)}
  end

  def do_handle_event(action, _params, socket) do
    gleam_store = :gleam_app.update(socket.assigns.gleam_store, action, :none)
    {:noreply, assign(socket, gleam_store: gleam_store)}
  end

  def render(assigns) do
    assigns =
      assigns
      |> assign(
        counter_value: :gleam_app.get_counter_value(assigns.gleam_store),
        counter_step: :gleam_app.get_counter_step(assigns.gleam_store)
      )

    ~H"""
    <div class="container mx-auto py-16 pb-24 text-2xl">
      <h2 class="text-center pb-3 select-none [text-shadow:0_2px_3px_rgba(0,0,0,.2)] font-medium">Counter</h2>
      <div class="mx-auto rounded-full bg-gradient-to-b from-indigo-500 via-purple-800 to-pink-500 w-44 h-44 flex items-center justify-center text-white font-bold text-3xl drop-shadow-md select-none [text-shadow:0_2px_4px_rgba(0,0,0,.67)] border-2 border border-indigo-400">
        <%= @counter_value %>
      </div>
      <div class="flex gap-2 justify-center pt-4">
        <button phx-click="decrement" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner border border-indigo-600">
          -
        </button>
        <form phx-change="set_step" onsubmit="return false;">
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
            input[type=number]::selection {
              color: white;
              background: black;
            }
            input[type=number]::-moz-selection {
              color: white;
              background: black;
            }
          </style>
          <input name="step" value={@counter_step} phx-debounce="blur" type="number" inputmode="numeric" pattern="\d*" step="1" autofocus="autofocus" class="block rounded w-14 h-14 font-xl border border-indigo-600 text-center focus:outline-none focus:ring focus:ring-violet-300"/>
        </form>
        <button phx-click="increment" class="block bg-indigo-500 text-white rounded w-14 h-14 font-xl hover:bg-indigo-700 drop-shadow select-none shadow hover:shadow-none hover:shadow-inner border border-indigo-600">
          +
        </button>
      </div>
    </div>
    """
  end
end
