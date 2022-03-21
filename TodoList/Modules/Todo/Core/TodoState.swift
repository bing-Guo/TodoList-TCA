import Foundation

struct Todo: Equatable, Identifiable {
    var id: UUID
    var description = ""
    var isComplete = false
}
