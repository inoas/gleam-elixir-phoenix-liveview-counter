import counter.{Counter}
import gleam/option

/// Creates the store
///
pub fn create_store(step: Int) -> Counter {
  counter.new(step)
}

/// Store action switches
///
pub type Action {
  Increment
  Decrement
  SetStep
}

/// Gets a list of all actions, used to detect valid user input on the liveview side
///
pub fn actions() -> List(Action) {
  [Increment, Decrement, SetStep]
}

/// Updates the store
///
/// TODO: This could possibly take an Action variant that contains a payload
///       instead of having the payload as a separate arg.
///
pub fn update(
  counter: Counter,
  message: Action,
  payload: option.Option(Int),
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

/// Store value getter
///
pub fn get_counter_value(counter: Counter) -> Int {
  counter
  |> counter.get_value
}

/// Store counter getter
///
pub fn get_counter_step(counter: Counter) -> Int {
  counter
  |> counter.get_step
}
