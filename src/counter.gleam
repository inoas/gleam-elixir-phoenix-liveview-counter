import gleam/option

/// Opaque types can only be constructed via their module's functions
///
pub opaque type Counter {
  Counter(step: Int, value: Int)
}

/// Creates a new Counter
///
/// Takes a step value during construction.
/// If 0 or negative is given, then the step value is set to 1.
///
pub fn new(step: Int) -> Counter {
  case step <= 0 {
    True -> Counter(step: 1, value: 0)
    False -> Counter(step: step, value: 0)
  }
}

/// Increments a Counter
///
pub fn increment(counter: Counter) -> Counter {
  Counter(..counter, value: counter.value + counter.step)
}

/// Decrements a Counter
///
pub fn decrement(counter: Counter) -> Counter {
  let next_value = counter.value - counter.step
  case next_value < 0 {
    True -> Counter(..counter, value: 0)
    False -> Counter(..counter, value: next_value)
  }
}

/// Sets the step value
/// If a non-positive (1+) isn't given it sets the step value to 1.
///
pub fn set_step(counter: Counter, payload: option.Option(Int)) -> Counter {
  let step = option.unwrap(payload, or: 1)
  case step <= 0 {
    True -> Counter(..counter, step: 1)
    False -> Counter(..counter, step: step)
  }
}

/// Getter for the value
///
pub fn get_value(counter: Counter) -> Int {
  counter.value
}

/// Getter for the step
///
pub fn get_step(counter: Counter) -> Int {
  counter.step
}
