//
//  GoogleSignInButton.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/31/22.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    private var button = GIDSignInButton()
    
    func makeUIView(context: Context) -> GIDSignInButton {
        button.colorScheme = colorScheme == .dark ? .light : .light
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        button.colorScheme = colorScheme == .dark ? .light : .light
    }
}
