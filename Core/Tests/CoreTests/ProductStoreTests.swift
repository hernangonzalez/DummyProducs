import XCTest
import Models
@testable import Core

final class ProductStoreTests: XCTestCase {
    func testAvailableOnInit() async throws {
        // Given
        let net = MockNetwork()
        let sut = ProductStore(net: net)

        // When
        let items = await sut.available()

        // Then
        XCTAssertTrue(items.isEmpty)
    }

    func testRefresh() async throws {
        // Given
        let net = MockNetwork()
        net.data = Json.prods.data(using: .utf8)!
        let sut = ProductStore(net: net)

        // When
        try await sut.refresh()
        let items = await sut.available()

        // Then
        XCTAssertNotNil(net.didCall_perform)
        XCTAssertTrue(net.didCall_perform! is ProductStockAPI)
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.title, "iPhone 9")
    }

    func testTakeAvailable() async throws {
        // Given
        let net = MockNetwork()
        net.data = Json.prods.data(using: .utf8)!
        let sut = ProductStore(net: net)
        let pid: Product.ID = 1

        // When
        try await sut.refresh()
        let item = try await sut.take(pid, count: 1)

        // Then
        XCTAssertEqual(item.title, "iPhone 9")
        XCTAssertEqual(item.stock, 93)
    }

    func testTakeOverflow() async throws {
        // Given
        let net = MockNetwork()
        net.data = Json.prods.data(using: .utf8)!
        let sut = ProductStore(net: net)
        let pid: Product.ID = 1

        // When
        try await sut.refresh()
        var err: CoreError?
        do {
            _ = try await sut.take(pid, count: 100)
        } catch {
            err = error as? CoreError
        }

        // Then
        XCTAssertEqual(err, .notEnoughStock)
    }
}
