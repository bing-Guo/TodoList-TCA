import ComposableArchitecture

/**
 The state is typically a **struct** because it holds a bunch of independent pieces of data, though it does not always need to be a struct.

 In order for the view store to know how to deduplicate emissions of state, we should make our state structs `Equatable`.
 */
struct AppState: Equatable {
    /**
     If use Array<Todo>, it will show the warning `'forEach(state:action:environment:breakpointOnNil:file:line:)' is deprecated: Use the 'IdentifiedArray'-based version, instead`
     The solution is here: https://tagmerge.com/issue/pointfreeco/swift-composable-architecture/854
     */
    var todos: IdentifiedArrayOf<Todo>
}
