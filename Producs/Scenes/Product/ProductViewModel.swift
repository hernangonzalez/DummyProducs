//
//  ProductViewModel.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 21/04/2023.
//

import Foundation
import Models

struct ProductViewModel {
    let app: any ObservableApplication
    let item: Product
}

extension ProductViewModel {
    var title: String { item.title.capitalized }
    var description: String { item.title.description }
    var price: Double { item.price }
    var images: [URL] { item.images }
    var stock: UInt { item.stock }
    var disabled: Bool { item.stock == 0 }

    func take() {
        Task {
            do  {
                try await app.take(pid: item.id)
            } catch {
                // TBI: present error
                debugPrint(error)
            }
        }
    }
}
