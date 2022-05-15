pub opaque type Counter {
  Counter(step: Int, value: Int)
}

pub fn new(step: Int) -> Counter {
  case step {
    0 -> Counter(step: 1, value: 0)
    _ -> Counter(step: step, value: 0)
  }
}

pub fn increment(counter: Counter) -> Counter {
  Counter(..counter, value: counter.value + counter.step)
}

pub fn decrement(counter: Counter) -> Counter {
  let new_value = counter.value - counter.step
  case new_value {
    new_value if new_value < 0 -> Counter(..counter, value: 0)
    new_value -> Counter(..counter, value: new_value)
  }
}

pub fn get_value(counter: Counter) -> Int {
  counter.value
}
