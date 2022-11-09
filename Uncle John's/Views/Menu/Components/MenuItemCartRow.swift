//
//  MenuItemCartRow.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct MenuItemCartRow: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    var menuItem: MenuItem
    var icon: String = "xmark"
    var onDelete: ()->()
    
    // MARK: Animation Properties
    @State var offsetX: CGFloat = 0
    @State var cardOffset: CGFloat = 0
    @State var finishAnimation: Bool = false
    
    var body: some View {
        let cardWidth = screenSize().width - 30
        let progress = (-offsetX * 0.8) / screenSize().width
        
        ZStack(alignment: .trailing) {
            CanvasView()
            
            HStack(spacing: 20) {
                Image(menuItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(menuItem.name)
                        .font(.custom("AvenirNext-DemiBold", size: 16))
                    
                    Text("$\(String(format: "%.2f", menuItem.price))")
                        .font(.custom("AvenirNext-Regular", size: 16))
                }
                
                Spacer()
                
                Group {
                    Text("QTY: ").font(.custom("AvenirNext-Bold", size: 16)) +
                    Text("1").font(.custom("AvenirNext-Regular", size: 16))
                }
                .padding(.trailing, 10)
            }
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(Color("CustomGray"))
            }
            .padding(.horizontal)
            .opacity(1 - progress)
            .blur(radius: progress * 5.0)
            .contentShape(Rectangle())
            .offset(x: cardOffset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        // MARK: Only left swife
                        var translation = value.translation.width
                        translation = (translation > 0 ? 0 : translation)
                        // Stopping the card end
                        translation = (-translation < cardWidth ? translation : -cardWidth)
                        offsetX = translation
                        cardOffset = offsetX
                    })
                    .onEnded({ value in
                        // MARK: Release animation
                        if -value.translation.width > (screenSize().width * 0.6) {
                            // MARK: Haptic feedback
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            finishAnimation = true
                            
                            // moving card outside of the screen
                            withAnimation(.easeInOut(duration: 0.3)) {
                                cardOffset = -screenSize().width
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                onDelete()
                            }
                        } else {
                            // MARK: Snap back in place
                            withAnimation(.easeInOut(duration: 0.3)) {
                                offsetX = .zero
                                cardOffset = .zero
                            }
                        }
                    })
            )
        }
    }
    
    // MARK: "Gooey Cell" Animation
    @ViewBuilder
    func CanvasView() -> some View {
        let width = (screenSize().width * 0.8)
        let circleOffset = (offsetX / width)
        
        Canvas { ctx, size in
            // Since we applied effect here, it will be smooth
            ctx.addFilter(.alphaThreshold(min: 0.5, color: Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])")))
            ctx.addFilter(.blur(radius: 5))
            
            ctx.drawLayer { layer in
                if let resolvedView = ctx.resolveSymbol(id: 1) {
                    layer.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                }
            }
        } symbols: {
            GooeyView()
                .tag(1)
        }
        // MARK: Icon View
        .overlay(alignment: .trailing) {
            Image(systemName: icon)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 42, height: 42)
                // MARK: Moving View Inside
                .offset(x: 42)
                .offset(x: (-circleOffset < 1.0 ? circleOffset : -1.0) * 42)
                .offset(x: offsetX * 0.2)
                .offset(x: 8)
                .offset(x: finishAnimation ? -200 : 0)
                .opacity(finishAnimation ? 0 : 1)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 1, blendDuration: 1), value: finishAnimation)
        }
    }
    
    @ViewBuilder
    func GooeyView() -> some View {
        let width = (screenSize().width * 0.8)
        let scale = finishAnimation ? -0.0001 : (offsetX / width)
        let circleOffset = (offsetX / width)
        
        Image("Shape")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
            .scaleEffect(x: -scale, anchor: .trailing)
        // MARK: Adding some y scaling
            .scaleEffect(y: 1 + (-scale / 5), anchor: .center)
            // MARK: Add Icon View
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: finishAnimation)
            .overlay(alignment: .trailing, content: {
                Circle()
                    .frame(width: 42, height: 42)
                    // MARK: Moving View Inside
                    .offset(x: 42)
                    .scaleEffect(finishAnimation ? 0.001 : 1, anchor: .leading)
                    .offset(x: (-circleOffset < 1.0 ? circleOffset : -1.0) * 42)
                    .offset(x: offsetX * 0.2)
                    .offset(x: finishAnimation ? -200 : 0)
                    .animation(.interactiveSpring(response: 0.6, dampingFraction: 1, blendDuration: 1), value: finishAnimation)
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .offset(x: 8)
    }
}

extension View {
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}

struct MenuItemCartRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            MenuItemCartRow(menuItem: menuList[0]) {
                
            }
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
        }
    }
}
