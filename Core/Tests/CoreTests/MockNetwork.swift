import Foundation
@testable import Core

enum Json {
    static let prods = ###"{"limit":1,"products":[{"brand":"Apple","category":"smartphones","description":"An apple mobile which is nothing like apple","discountPercentage":12.96,"id":1,"images":["https://i.dummyjson.com/data/products/1/1.jpg","https://i.dummyjson.com/data/products/1/2.jpg","https://i.dummyjson.com/data/products/1/3.jpg","https://i.dummyjson.com/data/products/1/4.jpg","https://i.dummyjson.com/data/products/1/thumbnail.jpg"],"price":549,"rating":4.69,"stock":94,"thumbnail":"https://i.dummyjson.com/data/products/1/thumbnail.jpg","title":"iPhone 9"}],"skip":0,"total":100}"###
}


final class MockNetwork: Networking {
    var data: Data = .init()
    var didCall_perform: (any Core.API)?

    func perform<T>(_ api: T) async throws -> T.Response where T : Core.API {
        didCall_perform = api
        return try api.json(from: data)
    }
}
