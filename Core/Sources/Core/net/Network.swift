import Foundation
import Models

protocol Networking {
    func perform<T: API>(_ api: T) async throws -> T.Response
}

actor Network {
    private let session: URLSession = .init(configuration: .default)
}

extension Network: Networking {
    func perform(_ req: URLRequest) async throws -> Data {
        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse, http.isValid() else {
            throw CoreError.badNetwork
        }
        return data
    }

    func perform<T: API>(_ api: T) async throws -> T.Response {
        let data = try await perform(api.asRequest())
        return try api.json(from: data)
    }
}

private extension HTTPURLResponse {
    func isValid() -> Bool {
        (200...299).contains(statusCode)
    }
}
