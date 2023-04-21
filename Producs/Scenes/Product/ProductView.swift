//
//  ProductView.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 21/04/2023.
//

import SwiftUI

struct ProductView: View {
    var model: ProductViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if let thumb = model.images.first {
                AsyncImage(url: thumb) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .allowsHitTesting(false)
                    }
                }
                .frame(height: 160)
                .background(.gray)
                .clipped()
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.title.capitalized)
                        .font(.title2)
                        .lineLimit(1)
                    Text(model.description)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                    Spacer()
                }
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Price: \(model.price)")
                            .font(.body.bold())
                            .foregroundColor(.gray)
                        Text("Available: \(model.stock)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button("Add to cart") { model.take() }
                        .buttonStyle(GrowingButton(disabled: model.disabled))
                        .disabled(model.disabled)
                }

            }
            .padding()
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(model: .init(
            app: PreviewApplication(),
            item: .init(id: 11, title: "Title", description: "desc", price: 100, stock: 42, images: []))
        )
    }
}
