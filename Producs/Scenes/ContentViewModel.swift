//
//  ContentViewModel.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 21/04/2023.
//

import Foundation
import Models
import Core
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    @Published
    private var app: any ObservableApplication

    init(app: any ObservableApplication) {
        self.app = app
    }
}

extension ContentViewModel {
    var cartCount: UInt { app.state.cartCount }

    var items: [Product] {
        app.state.products
            .sorted { $0.title < $1.title }
    }

    func viewDidAppear() async {
        do {
            try await app.refresh()
        } catch {
            // TODO: Present user with an error message.
            debugPrint(error)
        }
    }

    func model(for item: Product) -> ProductViewModel {
        .init(app: app, item: item)
    }
}
