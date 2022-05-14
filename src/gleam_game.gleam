pub fn create_store() -> Int {
  0
}

pub type Action {
  Increment
  Decrement
}

pub fn actions() -> List(Action) {
  [Increment, Decrement]
}

pub fn update(store: Int, message: Action) -> Int {
  case message {
    Increment -> store + 1
    Decrement -> store - 1
  }
}
