//
//  PaymentCards.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/17/22.
//

import SwiftUI

struct PaymentCards: View {
    @State var tabSelectionIndex = 0
    var width: CGFloat = 275
    var height: CGFloat = 500
    
    var body: some View {
        TabView (selection: $tabSelectionIndex) {
            VStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                        .frame(height: height * 0.3)
                    
                    Image("Mastercard")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.white)
                        .frame(width: width * 0.5)
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: height * 0.7)
                    
                    VStack {
                        Group {
                            Text(".... .... .... 9678")
                            Text("Exp. 04/27")
                        }
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .textCase(.uppercase)
                        .foregroundColor(.black)
                        
                        Image("Test QR Code")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom, 30)
                        
                        Button {
                            // Action goes here later
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 23)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(width: width, height: height)
            .cornerRadius(20)
            .tag(0)
            
            VStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 35/255, green: 35/255, blue: 66/255))
                        .frame(height: height * 0.3)
                    
                    Image("Discover (Dark)")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.white)
                        .frame(width: width * 0.5)
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: height * 0.7)
                    
                    VStack {
                        Group {
                            Text(".... .... .... 9678")
                            Text("Exp. 04/27")
                        }
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .textCase(.uppercase)
                        .foregroundColor(.black)
                        
                        Image("Test QR Code")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom, 30)
                        
                        Button {
                            // Action goes here later
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 23)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(width: width, height: height)
            .cornerRadius(20)
            .tag(1)
            
            VStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 20/255, green: 52/255, blue: 203/255))
                        .frame(height: height * 0.3)
                    
                    Image("Visa")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: width * 0.5)
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: height * 0.7)
                    
                    VStack {
                        Group {
                            Text(".... .... .... 9678")
                            Text("Exp. 04/27")
                        }
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .textCase(.uppercase)
                        .foregroundColor(.black)
                        
                        Image("Test QR Code")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom, 30)
                        
                        Button {
                            // Action goes here later
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 23)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(width: width, height: height)
            .cornerRadius(20)
            .tag(2)
            
            VStack (spacing: 0) {
                ZStack (alignment: .trailing) {
                    Rectangle()
                        .foregroundColor(Color(red: 38/255, green: 112/255, blue: 183/255))
                        .frame(height: height * 0.3)
                    
                    ZStack {
                        Color.white
                        
                        Image("American Express")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(Color(red: 38/255, green: 112/255, blue: 183/255))
                    }
                    .frame(width: width * 0.5)
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: height * 0.7)
                    
                    VStack {
                        Group {
                            Text(".... .... .... 9678")
                            Text("Exp. 04/27")
                        }
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .textCase(.uppercase)
                        .foregroundColor(.black)
                        
                        Image("Test QR Code")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom, 30)
                        
                        Button {
                            // Action goes here later
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(width: 23)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(width: width, height: height)
            .cornerRadius(20)
            .tag(3)
        }
        .frame(width: .infinity, height: height + 100)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct VerticalCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor (UJB)")
                .ignoresSafeArea()
            PaymentCards()
        }
        .colorScheme(.dark)
    }
}
