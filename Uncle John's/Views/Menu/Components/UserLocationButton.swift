//
//  UserLocationButton.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/1/22.
//

import SwiftUI

struct UserLocationButton: View {
    var body: some View {
        Image(systemName: "location.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .font(.headline)
            .foregroundColor(Color("ForegroundColor"))
            .padding(10)
            .background(Color("BackgroundColor"))
            .cornerRadius(5)
    }
}

struct UserLocationButton_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationButton()
            .colorScheme(.dark)
    }
}
