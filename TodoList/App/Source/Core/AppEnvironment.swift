import ComposableArchitecture
import Foundation
/**
 A type that holds any dependencies the feature needs, such as API clients, analytics clients, etc.
 */
struct AppEnvironment {
    var uuid: () -> UUID
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
