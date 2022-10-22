//
//  PaymentMethodsView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/21/22.
//

import SwiftUI

struct PaymentMethodsView: View {
    @State var cards: [Card] = []
    @State var isBlurEnabled: Bool = false
    @State var isRoationEnabled: Bool = true
    // TODO: add gift cards and coupons/promotions
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Enable Blur", isOn: $isBlurEnabled)
            Toggle("Turn On Rotation", isOn: $isRoationEnabled)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            BoomerangCard(isBlurEnabled: isBlurEnabled, isRoationEnabled: isRoationEnabled, cards: $cards)
                .frame(height: 220)
                .padding(.horizontal, 15)
        }
        .padding(15)
        .background {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
        .onAppear(perform: setupCards)
    }
    
    // MARK: Setting up cards
    func setupCards() {
        for _ in 1...8 {
            cards.append(.init(name: "Chase"))
        }
        
        // For infinite cards
        // logic is simple, place the first card at last
        // when last card is arrived, set index to 0
        if var first = cards.first {
            first.id = UUID().uuidString
            cards.append(first)
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodsView()
            .colorScheme(.dark)
    }
}

// MARK: Boomerang Card View

struct BoomerangCard: View {
    var isBlurEnabled: Bool = false
    var isRoationEnabled: Bool = false
    @Binding var cards: [Card]
    
    // MARK: Gesture properties
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                ForEach(cards.reversed()) { card in
                    CardView(card: card, size: size)
                    // MARK: Moving only current active card
                        .offset(y: currentIndex == indexOf(card: card) ? offset : 0)
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 2)
                    .onChanged(onChanged(value:))
                    .onEnded(onEnded(value:))
            )
        }
    }
    
    // MARK: gesture calls
    
    func onChanged(value: DragGesture.Value) {
        // for safety
        offset = currentIndex == (cards.count - 1) ? 0 : value.translation.height
    }
    
    func onEnded(value: DragGesture.Value) {
        var translation = value.translation.height
        // since we only need negative
        translation = (translation < 0 ? -translation : 0)
        translation = (currentIndex == (cards.count - 1) ? 0 : translation)
        
        // MARK: since our card height = 220
        if translation > 110 {
            // MARK: doing boomerang effect and updating current index
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                // applying rotation and extra offset
                cards[currentIndex].isRotated = true
                // give slightly bigger than card height
                cards[currentIndex].extraOffset = -350
                cards[currentIndex].scale = 0.7
            }
            
            // after a little delay resetting gesture offset and extra offset
            // pushing card into back using z-index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                    cards[currentIndex].zIndex = -100
                    for index in cards.indices {
                        cards[index].extraOffset = 0
                    }
                    // MARK: Updating current index
                    if currentIndex != (cards.count - 1) {
                        currentIndex += 1
                    }
                    offset = .zero
                }
            }
            
            // after animation completed resetting rotation and scaling and setting proper zindex
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                for index in cards.indices {
                    if index == currentIndex {
                        // MARK: placing the card at right index
                        // NOTE: since the current index is updated +1 previously
                        // so the current index will be -1 now
                        if cards.indices.contains(currentIndex - 1) {
                            cards[currentIndex - 1].zIndex = ZIndex(card: cards[currentIndex - 1])
                        }
                    } else {
                        cards[index].isRotated = false
                        withAnimation(.linear) {
                            cards[index].scale = 1
                        }
                    }
                }
                
                if currentIndex == (cards.count - 1) {
                    // resetting index to 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        for index in cards.indices {
                            // resetting zindex
                            cards[index].zIndex = 0
                        }
                        currentIndex = 0
                    }
                }
            }
        } else {
            offset  = .zero
        }
    }
    
    func ZIndex(card: Card) -> Double {
        let index = indexOf(card: card)
        let totalCount = cards.count
        
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    
    @ViewBuilder
    func CardView(card: Card, size: CGSize) -> some View {
        let index = indexOf(card: card)
        // MARK: ur custom view
        PaymentCard(name: "Chase", width: size.width)
            .blur(radius: card.isRotated && isBlurEnabled ? 6.5 : 0)
            .scaleEffect(card.scale, anchor: card.isRotated ? .center : .top)
            .rotation3DEffect(.init(degrees: isRoationEnabled && card.isRotated ? 360 : 0), axis: (x: 0, y: 0, z: 1))
            .offset(y: -offsetFor(index: index))
            .offset(y: card.extraOffset)
            .scaleEffect(scaleFor(index: index), anchor: .top)
            .zIndex(card.zIndex)
//        Image(card.name)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: size.width, height: size.height)
//            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    // MARK: Scale and offset values for each card
    // addressing negative indexes
    func scaleFor(index value: Int) -> Double {
        let index = Double(value - currentIndex)
        // MARK: only showing 3 cards
        if index >= 0 {
            if index > 3 {
                return 0.8
            }
            // for each card 0.06 scale will be reduced
            return 1 - (index / 15)
        } else {
            if -index > 3 {
                return 0.8
            }
            return 1 + (index / 15)
        }
    }
    
    func offsetFor(index value: Int) -> Double {
        let index = Double(value - currentIndex)
        // MARK: only showing 3 cards
        if index >= 0 {
            if index > 3 {
                return 30
            }
            return index * 10
        } else {
            if -index > 3 {
                return 30
            }
            return -index * 10
        }
    }
    
    func indexOf(card: Card) -> Int {
        if let index = cards.firstIndex(where: { CCard in
            CCard.id == card.id
        }) {
            return index
        }
        return 0
    }
}
