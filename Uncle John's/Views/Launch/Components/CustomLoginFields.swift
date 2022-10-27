//
//  CustomLoginFields.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/27/22.
//

import SwiftUI

struct CustomLoginField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.opacity(0.3)
                    .font(.custom("AvenirNext-Medium", size: 16))
                    .foregroundColor(.black)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .foregroundColor(.black)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
    }
}

struct CustomPasswordField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.opacity(0.3)
                    .font(.custom("AvenirNext-Medium", size: 16))
                    .foregroundColor(.black)
            }
            SecureField("", text: $text)
                .foregroundColor(.black)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
    }
}

