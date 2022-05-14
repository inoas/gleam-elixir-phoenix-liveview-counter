pub fn create_store() -> Int {
  0
}

pub fn update(store: Int, message: String) -> Int {
  case message {
    "increment" -> store + 1
    "decrement" -> store - 1
  }
}
