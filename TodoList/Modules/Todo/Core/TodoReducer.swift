import ComposableArchitecture

let todoReducer = Reducer<Todo, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case .checkboxTapped:
        state.isComplete.toggle()
        return .none // Effect
    case let .textFieldChanged(text):
        state.description = text
        return .none
    }
}.debug() // Prints debug messages describing all received actions and state mutations.
