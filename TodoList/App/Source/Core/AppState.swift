/**
 A type that describes the data your feature needs to perform its logic and render its UI.
 
 The state is typically a **struct** because it holds a bunch of independent pieces of data, though it does not always need to be a struct.

 In order for the view store to know how to deduplicate emissions of state, we should make our state structs `Equatable`.
 */
struct AppState: Equatable {
    var todos: [Todo]
}
