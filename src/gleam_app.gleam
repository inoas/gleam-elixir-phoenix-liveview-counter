import counter.{Counter}

pub fn create_store(step: Int) -> Counter {
  counter.new(step)
}

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
