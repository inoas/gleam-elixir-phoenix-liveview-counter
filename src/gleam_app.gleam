// non-OTP part:
import counter.{Counter}
import gleam/option.{Option}
//
// OTP part:
import gleam/io
import gleam/otp/actor
import gleam/otp/process.{Sender}

// OTP part:
pub type Message {
  Request(reply_channel: Sender(String))
}

pub fn start_process() {
  let state = create_store(2)
  assert Ok(channel) = actor.start(state, handle_message)
  process.call(channel, Request, 100)
  channel
}

fn handle_message(message, state) {
  io.print("The actor got a message: ")
  io.debug(message)
  process.send(message.reply_channel, "Done")
  actor.Continue(state)
}

pub fn send_message(channel, message) {
  actor.send(channel, message)
}

// non-OTP part:
pub fn create_store(step: Int) -> Counter {
  counter.new(step)
}

pub type Action {
  Increment
  Decrement
  SetStep
}

pub fn actions() -> List(Action) {
  [Increment, Decrement, SetStep]
}

pub fn update(
  counter: Counter,
  message: Action,
  payload: Option(Int),
) -> Counter {
  case message {
    Increment ->
      counter
      |> counter.increment
    Decrement ->
      counter
      |> counter.decrement
    SetStep ->
      counter
      |> counter.set_step(payload)
  }
}

pub fn get_counter_value(counter: Counter) -> Int {
  counter
  |> counter.get_value
}

pub fn get_counter_step(counter: Counter) -> Int {
  counter
  |> counter.get_step
}
