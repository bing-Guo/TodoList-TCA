//
//  ContentView.swift
//  TodoList
//
//  Created by Bing Kuo on 2022/3/17.
//

import ComposableArchitecture
import SwiftUI

struct Todo: Equatable, Identifiable {
    var id: UUID
    var description = ""
    var isComplete = false
}

struct AppState: Equatable {
    var todos: [Todo]
}

enum AppAction {
    case todoCheckboxTapped(index: Int)
    case todoTextFieldChanged(index: Int, text: String)
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case let .todoCheckboxTapped(index):
        state.todos[index].isComplete.toggle()
        return .none // Effect
    case let .todoTextFieldChanged(index, text):
        state.todos[index].description = text
        return .none
    }
}.debug()

struct ContentView: View {
    let store: Store<AppState, AppAction>
    // @ObservableObject var viewStore
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                List {
                    // zip(viewStore.todos.indices, viewStore.todos)
                    ForEach(Array(viewStore.todos.enumerated()), id: \.element.id) { index, todo in
                        HStack {
                            Button(action: { viewStore.send(.todoCheckboxTapped(index: index)) }) {
                                Image(systemName: todo.isComplete ? "checkmark.square" : "square")
                            }
                            .buttonStyle(.plain)
                            
                            TextField(
                                "Untitled todo",
                                text: viewStore.binding(
                                    get: { $0.todos[index].description },
                                    send: { .todoTextFieldChanged(index: index, text: $0) }
                                )
                            )
                        }
                        .foregroundColor(todo.isComplete ? .gray : nil)
                    }
                }
                .navigationTitle("Todos")
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
