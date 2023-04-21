import Foundation
import Models

public extension Collection where Element: Identifiable {
    func find(with id: Element.ID) throws -> Element {
        let match = first { $0.id == id }
        switch match {
        case let .some(value): return value
        case .none: throw CoreError.notFound
        }
    }

    func asDictionary() -> [Element.ID: Element] {
        reduce(into: .init()) { $0[$1.id] = $1 }
    }
}
