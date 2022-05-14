defmodule MeetupWeb.Game do
  use Phoenix.LiveView, layout: {MeetupWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:")}
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-12 text-2xl">
      <h1>Counter: <%= @score %></h1>
      <h2>
        <%= @message %>
      </h2>
      <div class="pt-8">
        <%= for n <- 1..10 do %>
          <button href="#" phx-click="guess" phx-value-number={n} class="bg-indigo-500 text-white rounded	p-2 w-16  hover:bg-indigo-700">
      		<%= n %>
     		</button>
        <% end %>
    	</div>
    </div>
    """
  end
end
