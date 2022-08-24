//
//  LocationDeniedView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/10/22.
//

import SwiftUI

struct LocationDeniedView: View {
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Group {
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
                    Image("southside2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: frame.size.width, height: frame.size.height)
                }
                GeometryReader { proxy in
                    BlurView(style: .systemThinMaterial)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Whoops!")
                    .font(.custom("AvenirNext-Bold", size: 24))
                    .textCase(.uppercase)
                
                Text("We need to access your location to provide you with the best experience possible. You can change this at any time in your phone's settings with the button below!")
                    .font(.custom("AvenirNext-Medium", size: 18))
                    .padding(.bottom, 50)
                
                Button {
                    
                    // Open settings by getting the settings URL
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        
                        if UIApplication.shared.canOpenURL(url) {
                            // If we can open this settings URL, then open it
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    
                } label: {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("AccentColor \(Color.suffixArray[1])")) // Replaced restaurantModel.selectedRestaurant with 1
                            .frame(height: 48)
                            .cornerRadius(10)
                        
                        Text("Go to Settings")
                            .font(.custom("AvenirNext-Medium", size: 18))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
                
            }
            .padding()
            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[0])")) // Replaced restaurantModel.selectedRestaurant with 0
            .multilineTextAlignment(.center)
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
            .colorScheme(.dark)
    }
}
