//
//  SettingsView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/13/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        Form {
            Picker("App Icon", selection: $settings.iconIndex) {
                ForEach(settings.icons.indices, id: \.self) { index in
                    IconRow(icon: settings.icons[index])
                        .tag(index)
                }
            }
            .pickerStyle(.inline)
            .onChange(of: settings.iconIndex) { newIndex in
                guard UIApplication.shared.supportsAlternateIcons else {
                    print("App does not support alternate icons.")
                    return
                }
                
                let currentIndex = settings.icons.firstIndex(where: { icon in
                    return icon.iconName == settings.currentIconName
                }) ?? 0
                guard newIndex != currentIndex else { return }
                let newIconSelection = settings.icons[newIndex].iconName
                
                UIApplication.shared.setAlternateIconName(newIconSelection) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct IconRow: View {
    public let icon: Icon
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: icon.image ?? UIImage())
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .padding(.trailing)
            
            Text(icon.displayName)
                .bold()
        }
        .padding(8)
    }
}
