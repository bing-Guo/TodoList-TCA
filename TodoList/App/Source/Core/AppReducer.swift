import ComposableArchitecture

/**
 A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
 
 `combine`
 Combines many reducers into a single one by running each one on state in order, and merging all of the effects.
 
 `pullback`
 Transforms a reducer that works on local state, action, and environment into one that works on global state, action and environment
 
 `forEach`
 A version of pullback(state:action:environment:) that transforms a reducer that works on an element into one that works on an identified array of elements.
 */
let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    // todo
    todoReducer.forEach(
        state: \AppState.todos,
        action: /AppAction.todo(id:action:),
        environment: { _ in TodoEnvironment() }
    ),
    // other
    /// controll uuid dependency
    Reducer { state, action, environment in
        switch action {
        case .addButtonTapped:
            state.todos.insert(Todo(id: environment.uuid()), at: 0)
            return .none
            /// Capture TodoAction.checkboxTapped
        case .todo(id: _, action: .checkboxTapped):
            /// local and unique
            struct CancelDelayId: Hashable {}
            
            return Effect(value: .todoDelayCompleted)
                .debounce(
                    id: CancelDelayId(),
                    for: 1,
                    scheduler: environment.mainQueue
                )
            
        case .todo(id: let id, action: let action):
            /// ignore todo actions.
            return .none
            
        case .todoDelayCompleted:
            /// Use IdentifiedArrayOf.sort() to sort todos according isCompleted.
            state.todos.sort { $1.isComplete && !$0.isComplete }
            return .none
        }
    }
)
