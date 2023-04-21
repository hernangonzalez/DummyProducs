//
//  ProducsApp.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 20/04/2023.
//

import SwiftUI

@main
struct ProducsApp: App {
    @StateObject private var application: Application = .init()

    var body: some Scene {
        WindowGroup {
            ContentView(model: .init(app: application))
        }
    }
}
