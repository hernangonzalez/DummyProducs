import Foundation
import Models
import Combine

struct ProductResponse: Decodable {
    let products: [Product]
}

protocol API {
    associatedtype Response: Decodable
    func asRequest() -> URLRequest
}

extension API {
    func json(from data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

struct ProductStockAPI: API {
    typealias Response = ProductResponse
    
    func asRequest() -> URLRequest {
        let url = URL(string: "https://dummyjson.com/products")!;
        return URLRequest(url: url);
    }
}
