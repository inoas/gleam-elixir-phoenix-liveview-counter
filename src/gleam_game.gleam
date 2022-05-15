pub opaque type Counter {
  Counter(step: Int, value: Int)
}

pub fn create_store(step: Int) -> Counter {
  Counter(step: step, value: 0)
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
    Increment -> Counter(..counter, value: counter.value + counter.step)
    Decrement -> Counter(..counter, value: counter.value - counter.step)
  }
}

pub fn get_value(counter: Counter) -> Int {
  counter.value
}
