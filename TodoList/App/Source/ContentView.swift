import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    /**
     The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.
     */
    let store: Store<AppState, AppAction>
    
    /**
     `scope`
     Use `scope` to expose local state and actions when passing the store to subviews. In this way, you can limit the states that each page can access.
     */
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in // ViewStore<AppState, AppAction>
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.todos,
                            action: AppAction.todo(id:action:)
                        ),
                        content: TodoView.init(store:)
                    )
                }
                .navigationTitle("Todos")
                .navigationBarItems(trailing: Button("Add") {
                    viewStore.send(.addButtonTapped)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: AppState(
                    todos: [
                        Todo(id: UUID(), description: "Milk", isComplete: false),
                        Todo(id: UUID(), description: "Eggs", isComplete: true),
                        Todo(id: UUID(), description: "Hand Soap", isComplete: false),
                    ]
                ),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}
