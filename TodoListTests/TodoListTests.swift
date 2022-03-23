//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Bing Kuo on 2022/3/17.
//

import ComposableArchitecture
import XCTest
@testable import TodoList

class TodoListTests: XCTestCase {
    /// The test scheduler runs in virtual time unlike the main scheduler that runs in real time, so it can reduce test execution time.
    let scheduler = DispatchQueue.test
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCompleteTodo() throws {
        let store = TestStore(
            initialState: AppState(
                todos: [
                    Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, description: "Milk", isComplete: false),
                ]
            ),
            reducer: appReducer,
            environment: AppEnvironment(
                uuid: { fatalError("unimplemented") },
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )
        
        store.send(.todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, action: .checkboxTapped)) {
            $0.todos[id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!]!.isComplete = true
        }
        
        scheduler.advance(by: 1)
        
        store.receive(.todoDelayCompleted)
    }
    
    func testAddTodo() {
        let store = TestStore(
            initialState: AppState(todos: []),
            reducer: appReducer,
            environment: AppEnvironment(
                uuid: { UUID(uuidString: "00000000-0000-0000-0000-000000000000")! },
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )
        
        store.send(.addButtonTapped) {
            $0.todos = [
                Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, description: "", isComplete: false)
            ]
        }
    }
    
    func testTodoSorting() throws {
        let store = TestStore(
            initialState: AppState(
                todos: [
                    Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, description: "Milk", isComplete: false),
                    Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, description: "Eggs", isComplete: false),
                ]
            ),
            reducer: appReducer,
            environment: AppEnvironment(
                uuid: { fatalError("unimplemented") },
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )
        
        store.send(.todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, action: .checkboxTapped)) {
            $0.todos[id: $0.todos[0].id]?.isComplete = true
        }
        
        scheduler.advance(by: 1)
        
        store.receive(.todoDelayCompleted) {
            $0.todos = [
                $0.todos[1],
                $0.todos[0],
            ]
            
            // or
            // $0.todos.swapAt(0, 1)
            
            /// In my opinion, the code below looks more intuitive.
            // $0.todos = [
            //     Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, description: "Eggs", isComplete: false),
            //     Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, description: "Milk", isComplete: true)
            // ]
        }
    }
    
    func testTodoSorting_Cancellation() throws {
        let store = TestStore(
            initialState: AppState(
                todos: [
                    Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, description: "Milk", isComplete: false),
                    Todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, description: "Eggs", isComplete: false),
                ]
            ),
            reducer: appReducer,
            environment: AppEnvironment(
                uuid: { fatalError("unimplemented") },
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )
        
        store.send(.todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, action: .checkboxTapped)) {
            $0.todos[id: $0.todos[0].id]?.isComplete = true
        }
        
        scheduler.advance(by: 0.5)
        
        store.send(.todo(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, action: .checkboxTapped)) {
            $0.todos[id: $0.todos[0].id]?.isComplete = false
        }
        
        scheduler.advance(by: 1)
        
        store.receive(.todoDelayCompleted)
    }
}
