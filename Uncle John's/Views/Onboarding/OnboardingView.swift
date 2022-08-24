//
//  OnboardingView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/10/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var tabSelection = 0
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Group {
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
                    Image("southside\(tabSelection)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: frame.size.width, height: frame.size.height)
                }
                GeometryReader { proxy in
                    BlurView(style: .systemThinMaterial)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                TabView(selection: $tabSelection) {
                    VStack {
                        Image("Uncle John's Barbeque Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .padding(.bottom)
                        
                        Text("Welcome!")
                            .font(.custom("AvenirNext-Bold", size: 24))
                            .textCase(.uppercase)
                            .padding(.bottom)
                        
                        Text("The Uncle John's app allows you to seamlessly order from Uncle John's and Dat Donut!")
                            .font(.custom("AvenirNext-Medium", size: 16))
                    }
                    .foregroundColor(Color("ForegroundColor \(Color.suffixArray[0])")) // Replaced restaurantModel.selectedRestaurant with 0
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .tag(0)
                    
                    VStack {
                        Image("Uncle John's Barbeque Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .padding(.bottom)
                        
                        Text("Ready to start ordering?")
                            .font(.custom("AvenirNext-Bold", size: 24))
                            .textCase(.uppercase)
                            .padding(.bottom)
                        
                        Text("We'll show you the best route to head over to Uncle John's! Click the button below.")
                            .font(.custom("AvenirNext-Medium", size: 16))
                    }
                    .foregroundColor(Color("ForegroundColor \(Color.suffixArray[0])")) // Replaced restaurantModel.selectedRestaurant with 0
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                // Button
                Button {
                    if tabSelection == 0 {
                        tabSelection = 1
                    }
                    else {
                        // Request permission for geolocating
                        restaurantModel.requestGeolocationPermission()
                    }
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(tabSelection == 0 ? .white : Color("AccentColor \(Color.suffixArray[1])")) // Replaced restaurantModel.selectedRestaurant with 1
                            .frame(height: 48)
                            .cornerRadius(10)
                        
                        Text( tabSelection == 0 ? "Next" : "Get My Location")
                            .font(.custom("AvenirNext-Medium", size: 18))
                            .padding()
                    }
                }
                .accentColor(tabSelection == 0 ? Color("AccentColor \(Color.suffixArray[1])") : Color.white) // Replaced restaurantModel.selectedRestaurant with 1
                .padding()
                
                Spacer()
            }
        }
    }
}

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // Do nothing
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
