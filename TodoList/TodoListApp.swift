//
//  TodoListApp.swift
//  TodoList
//
//  Created by Bing Kuo on 2022/3/17.
//

import ComposableArchitecture
import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: AppState(
                        todos: [
                            Todo(id: UUID(), description: "Milk", isComplete: false),
                            Todo(id: UUID(), description: "Eggs", isComplete: false),
                            Todo(id: UUID(), description: "Hand Soap", isComplete: false),
                        ]
                    ),
                    reducer: appReducer,
                    environment: AppEnvironment()
                )
            )
        }
    }
}
