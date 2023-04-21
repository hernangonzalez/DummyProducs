import Foundation
import Models
import Combine

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
    struct Response: Decodable {
        let products: [Product]
    }
    
    func asRequest() -> URLRequest {
        let url = URL(string: "https://dummyjson.com/products")!;
        return URLRequest(url: url);
    }
}
