//
//  EventCards.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/17/22.
//

import SwiftUI

struct EventCards: View {
    @State var tabSelectionIndex = 0
    
    var body: some View {
        TabView (selection: $tabSelectionIndex) {
            
            // MARK: - Back to School
            ZStack {
                Group {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .global)
                        Image("southside1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: frame.size.width, height: frame.size.height)
                    }
                    GeometryReader { proxy in
                        BlurView(style: .systemUltraThinMaterial)
                    }
                }
                
                VStack (alignment: .leading) {
                    Group {
                        Text("Sep 23: Back to School Event!")
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .padding(.top)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel felis eget justo posuere congue.")
                            .font(.custom("AvenirNext-Medium", size: 15))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        print("Learn More")
                    } label: {
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("ForegroundColor (Generic)").opacity(0.1))
                                .frame(height: 40)
                            
                            Text("Learn More")
                                .font(.custom("AvenirNext-Medium", size: 18))
                                .foregroundColor(Color("ForegroundColor (Generic)"))
                                .padding([.horizontal])
                        }
                    }
                }
            }
            .frame(width: 350, height: 150)
            .cornerRadius(15)
            .shadow(radius: 2, x: 2, y: 2)
            .padding()
            .tag(0)
            
            // MARK: - Food Drive
            ZStack {
                Group {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .global)
                        Image("southside0")
                            .resizable()
                            .scaledToFill()
                            .frame(width: frame.size.width, height: frame.size.height)
                    }
                    GeometryReader { proxy in
                        BlurView(style: .systemUltraThinMaterial)
                    }
                }
                
                VStack (alignment: .leading) {
                    Group {
                        Text("Sep 23: Food Drive!")
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .padding(.top)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel felis eget justo posuere congue.")
                            .font(.custom("AvenirNext-Medium", size: 15))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        print("Learn More")
                    } label: {
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("ForegroundColor (Generic)").opacity(0.1))
                                .frame(height: 40)
                            
                            Text("Learn More")
                                .font(.custom("AvenirNext-Medium", size: 18))
                                .foregroundColor(Color("ForegroundColor (Generic)"))
                                .padding([.horizontal])
                        }
                    }
                }
            }
            .frame(width: 350, height: 150)
            .cornerRadius(15)
            .shadow(radius: 2, x: 2, y: 2)
            .padding()
            .tag(1)
            
            // MARK: - Gas Giveaway!
            ZStack {
                Group {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .global)
                        Image("southside1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: frame.size.width, height: frame.size.height)
                    }
                    GeometryReader { proxy in
                        BlurView(style: .systemUltraThinMaterial)
                    }
                }
                
                VStack (alignment: .leading) {
                    Group {
                        Text("Sep 23: Gas Giveaway!")
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .padding(.top)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel felis eget justo posuere congue.")
                            .font(.custom("AvenirNext-Medium", size: 15))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        print("Learn More")
                    } label: {
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("ForegroundColor (Generic)").opacity(0.1))
                                .frame(height: 40)
                            
                            Text("Learn More")
                                .font(.custom("AvenirNext-Medium", size: 18))
                                .foregroundColor(Color("ForegroundColor (Generic)"))
                                .padding([.horizontal])
                        }
                    }
                }
            }
            .frame(width: 350, height: 150)
            .cornerRadius(15)
            .shadow(radius: 2, x: 2, y: 2)
            .padding()
            .tag(2)
            
            // MARK: - Toy Drive
            ZStack {
                Group {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .global)
                        Image("southside2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: frame.size.width, height: frame.size.height)
                    }
                    GeometryReader { proxy in
                        BlurView(style: .systemUltraThinMaterial)
                    }
                }
                
                VStack (alignment: .leading) {
                    Group {
                        Text("Sep 23: Toy Drive!")
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .padding(.top)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel felis eget justo posuere congue.")
                            .font(.custom("AvenirNext-Medium", size: 15))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        print("Learn More")
                    } label: {
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("ForegroundColor (Generic)").opacity(0.1))
                                .frame(height: 40)
                            
                            Text("Learn More")
                                .font(.custom("AvenirNext-Medium", size: 18))
                                .foregroundColor(Color("ForegroundColor (Generic)"))
                                .padding([.horizontal])
                        }
                    }
                }
            }
            .frame(width: 350, height: 150)
            .cornerRadius(15)
            .shadow(radius: 2, x: 2, y: 2)
            .padding()
            .tag(3)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct AdCards_Previews: PreviewProvider {
    static var previews: some View {
        EventCards()
            .colorScheme(.dark)
    }
}
