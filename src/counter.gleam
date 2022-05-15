import gleam/io

pub opaque type Counter {
  Counter(step: Int, value: Int)
}

pub fn new(step: Int) -> Counter {
  case step {
    0 -> Counter(step: 1, value: 0)
    _ -> Counter(step: step, value: 0)
  }
}

pub fn set_value(counter: Counter, value: Int) -> Counter {
  io.debug(value)
  case value {
    value if value < 0 -> Counter(..counter, value: 0)
    value -> Counter(..counter, value: value)
  }
}

pub fn get_value(counter: Counter) -> Int {
  counter.value
}
