//
//  GrowingButton.swift
//  Producs
//
//  Created by Hernan G. Gonzalez on 21/04/2023.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    let disabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(disabled ? .gray : .blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
