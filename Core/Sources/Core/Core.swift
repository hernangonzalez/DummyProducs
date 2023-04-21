// The Swift Programming Language
// https://docs.swift.org/swift-book
import Models

public enum Products { }

public extension Products {
    static func provider() -> ProductProvider {
        let network = Network()
        return ProductStore(net: network)
    }
}
