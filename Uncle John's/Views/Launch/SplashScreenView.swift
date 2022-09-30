//
//  SplashScreenView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/24/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            LaunchView()
        } else {
            ZStack {
                PatternBackground()
                
                Image("Uncle John's Barbeque Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.0)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

struct PatternBackground: View {
    var body: some View {
        ZStack {
            Color("LaunchBackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                ForEach(0..<20, id: \.self) { _ in
                    HStack {
                        ForEach(0..<15, id: \.self) { _ in
                            Image("Uncle John's Fire Icon")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 25, height: 15)
                        }
                    }
                    
                    HStack {
                        ForEach(0..<14, id: \.self) { _ in
                            Image("Uncle John's Fire Icon")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 25, height: 15)
                        }
                    }
                }
            }
        }
    }
}
