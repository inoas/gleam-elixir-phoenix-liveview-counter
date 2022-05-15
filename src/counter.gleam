pub opaque type Counter {
  Counter(step: Int, value: Int)
}

pub fn new(step: Int) -> Counter {
  case step <= 0 {
    True -> Counter(step: 1, value: 0)
    False -> Counter(step: step, value: 0)
  }
}

pub fn increment(counter: Counter) -> Counter {
  Counter(..counter, value: counter.value + counter.step)
}

pub fn decrement(counter: Counter) -> Counter {
  let next_value = counter.value - counter.step
  case next_value < 0 {
    True -> Counter(..counter, value: 0)
    False -> Counter(..counter, value: next_value)
  }
}

pub fn get_value(counter: Counter) -> Int {
  counter.value
}
