import Foundation
import Models
import Utils
import Combine

public protocol ProductProvider {
    func available() async -> any Collection<Product>
    func refresh() async throws

    @discardableResult
    func take(_ id: Product.ID, count: UInt) async throws -> Product
}

actor ProductStore {
    private let network: Networking
    private var stock: [Product.ID: Product] = .init()

    init(net: Networking) {
        self.network = net
    }
}

extension ProductStore: ProductProvider {
    func available() async -> any Collection<Product> { stock.values }

    func refresh() async throws {
        let api = ProductStockAPI()
        let resp = try await network.perform(api)
        self.stock = resp.products.asDictionary();
    }

    func take(_ id: Product.ID, count: UInt) async throws -> Product {
        guard var prod = stock[id] else {
            throw CoreError.notFound
        }
        try prod.take(count: count)
        stock[id] = prod
        return prod
    }
}

// MARK: - Private
private extension Product {
    mutating func take(count: UInt) throws {
        guard self.stock >= count else {
            throw CoreError.notEnoughStock
        }
        self.stock -= count
    }
}

