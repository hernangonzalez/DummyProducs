import Foundation

public struct Product: Codable, Identifiable {
    public let id: UInt
    public let title: String
    public let description: String
    public let price: Double
    public var images: [URL]
    public var stock: UInt

    public init(id: UInt, title: String, description: String, price: Double, stock: UInt, images: [URL]) {
        self.id = id
        self.title = title
        self.price = price
        self.stock = stock
        self.images = images
        self.description = description
    }
}

