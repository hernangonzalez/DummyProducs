//
//  Application.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 20/04/2023.
//

import Foundation
import Combine
import Core
import Models

struct ApplicationState {
    var products: any Collection<Product> = []
    var cart: UInt = 0
}

@MainActor
protocol ObservableApplication: ObservableObject {
    var state: ApplicationState { get }
    func refresh() async throws
    func take(pid: Product.ID) async throws
}

@MainActor
final class Application: ObservableApplication {
    @Published
    private(set) var state: ApplicationState = .init()
    private let products: ProductProvider = Products.provider()

    func refresh() async throws  {
        try await products.refresh()
        state.products = await products.available()
    }

    func take(pid: Product.ID) async throws {
        try await products.take(pid, count: 1)
        state.products =  await products.available()
        state.cart += 1
    }
}

@MainActor
final class PreviewApplication: ObservableApplication {
    let state: ApplicationState = .init(products: [
        .init(id: 1, title: "Mock Item", description: "El más grande sigue siendo River Plat", price: 100.0, stock: 42, images: [URL(string: "https://i.dummyjson.com/data/products/1/1.jpg")!])
    ])
    func refresh() async throws { }
    func take(pid: Product.ID) async throws { }
}
