import counter.{Counter}
import gleam/option.{Option}

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
