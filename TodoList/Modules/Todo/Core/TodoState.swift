import Foundation

/**
 Confirm the Identifiable protocol so that we can put it in forEach or IdentifiedArrayOf
 */
struct Todo: Equatable, Identifiable {
    var id: UUID
    var description = ""
    var isComplete = false
}
