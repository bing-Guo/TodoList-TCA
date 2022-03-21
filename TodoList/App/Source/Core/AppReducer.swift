import ComposableArchitecture

/**
 A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
 */
let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    // todo
    todoReducer.forEach(
        state: \AppState.todos,
        action: /AppAction.todo(index:action:),
        environment: { _ in TodoEnvironment() }
    ),
    // other
    Reducer { state, action, environment in
        switch action {
        case .addButtonTapped:
            state.todos.insert(Todo(id: UUID()), at: 0)
            return .none
        case .todo(index: let index, action: let action):
            return .none
        }
    }
)
