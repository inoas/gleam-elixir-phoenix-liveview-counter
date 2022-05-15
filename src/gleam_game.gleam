import gleam/io

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
    Increment -> {
      io.debug(#("gleam before inc", counter))
      io.debug(#("gleam before inc step", counter.step))
      io.debug(#("gleam before inc value", counter.value))
      let counter = Counter(..counter, value: counter.value + counter.step)
      io.debug(#("gleam after inc step", counter.step))
      io.debug(#("gleam after inc value", counter.value))
      io.debug(#("gleam after inc", counter))
      counter
    }
    Decrement -> {
      io.debug(#("gleam before inc", counter))
      io.debug(#("gleam before inc step", counter.step))
      io.debug(#("gleam before inc value", counter.value))
      let counter = Counter(..counter, value: counter.value - counter.step)
      io.debug(#("gleam after inc step", counter.step))
      io.debug(#("gleam after inc value", counter.value))
      io.debug(#("gleam after inc", counter))
      counter
    }
  }
}
