/**
 A type that represents all of the actions that can happen in your feature, such as user actions, notifications, event sources and more.
 
 The actions are typically an enum because it represents one of many different types of actions that a user can perform in the UI, such as tapping a button or entering text into a text field.
 */
enum AppAction {
    case addButtonTapped
    case todo(id: Todo.ID, action: TodoAction)
}
