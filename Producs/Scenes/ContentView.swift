//
//  ContentView.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 20/04/2023.
//

import SwiftUI
import Models
import Core

struct ContentView: View {
    @StateObject var model: ContentViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(model.items) { item in
                        ProductView(model: model.model(for: item))
                            .background(Color(UIColor.secondarySystemBackground))
                            .border(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(14)
                            .clipped()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle(L10n.General.title)
            .toolbar {
                HStack {
                    Text("\(model.cartCount)").font(.headline)
                    Image(systemName: "cart")
                }
            }
        }
        .padding()
        .task { await model.viewDidAppear() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: .init(app: PreviewApplication()))
    }
}
