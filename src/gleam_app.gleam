// non-OTP part:
import counter.{Counter}
// OTP part:
import gleam/io
import gleam/otp/actor
import gleam/otp/process.{Sender}

// OTP part:
pub type Message {
  Request(reply_channel: Sender(Counter))
}

pub fn start_otp(state) {
  assert Ok(channel) = actor.start(state, handle_message)
  process.call(channel, Request, 100)
  channel
}

fn handle_message(message, state) {
  io.println("The actor got a message")
  io.debug(message)
  process.send(message.reply_channel, state)
  actor.Continue(state)
}

pub fn create_store(step: Int) -> Counter {
  counter.new(step)
}

// non-OTP part:
pub type Action {
  Increment
  Decrement
}

pub fn actions() -> List(Action) {
  [Increment, Decrement]
}

pub fn update(counter: Counter, message: Action) -> Counter {
  case message {
    Increment ->
      counter
      |> counter.set_value(counter.get_value(counter) + 1)
    Decrement ->
      counter
      |> counter.set_value(counter.get_value(counter) - 1)
  }
}

pub fn get_counter_value(counter: Counter) -> Int {
  counter
  |> counter.get_value
}
