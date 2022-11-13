//
//  CartView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI
import MapKit
import Stripe

struct CartView: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var mapModel: MapModel
    @EnvironmentObject var appSettingsModel: AppSettingsModel
    @Environment(\.presentationMode) var presentationMode
    @State var isChecked: Bool = false
    @State var isCheckingOut: Bool = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    @State var message: String = ""
    let paymentGatewayController = PaymentGatewayController()
    let metersToMilesConversionMultiplier = 0.000621371
    
    var body: some View {
        let donation = isChecked ? ceil(cartModel.total * 1.1075) - cartModel.total * 1.1075 : 0
        GeometryReader { proxy in
            VStack {
                ScrollView(showsIndicators: false) {
                    
                    // MARK: - Your Trip
                    Group {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Your Trip")
                                    .font(.custom("AvenirNext-Bold", size: 20))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 1)
                                
                                HStack {
                                    Label("\(String(format: "%.0f", restaurantModel.routeETA / 60)) min", systemImage: "car.fill")
                                        .font(.custom("AvenirNext-Medium", size: 16)) // ETA is automatically in seconds, so we divide it by 60 to convert it to minutes.
                                    Text("(\(String(format: "%.1f", restaurantModel.routeDistance * metersToMilesConversionMultiplier)) mi)")
                                        .font(.custom("AvenirNext-Medium", size: 16)) // Distance is automatically is meters, so we multiply it by 6.21 × 10^(-4)
                                }
                            }
                            .padding(.vertical, 5)
                            Spacer()
                        }
                        
                        // Detect the authorization status of geolocating the user
                        if restaurantModel.authorizationState == .notDetermined {
                            HStack {
                                Spacer()
                                Button {
                                    // Request permission for geolocating
                                    restaurantModel.requestGeolocationPermission()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.blue)
                                            .frame(width: 200, height: 40)
                                        
                                        Label("Get My Location", systemImage: "location.fill")
                                            .font(.custom("AvenirNext-Medium", size: 18))
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.vertical)
                                Spacer()
                            }
                        }
                        else if restaurantModel.authorizationState == .authorizedAlways || restaurantModel.authorizationState == .authorizedWhenInUse {
                            // If approved, show map
                            ZStack(alignment: .topTrailing) {
                                DirectionsMap()
                                    .accentColor(Color("SkinTone\(appSettingsModel.emojiIndex)"))
                                    .frame(width: proxy.size.width - 50, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .environmentObject(MapModel())
                                
                                Button {
                                    withAnimation {
                                        restaurantModel.region = MKCoordinateRegion(center: restaurantModel.locationManager.location!.coordinate, span: MapDetails.closeUpSpan)
                                    }
                                } label: {
                                    UserLocationButton()
                                }
                                .padding([.top, .trailing], 10)
                            }
                            .padding(.bottom)
                            
                            // Apple and Google Maps Links
                            /* HStack {
                             Spacer()
                             Link(destination: URL(string: "https://maps.apple.com/?ll=\(41.744130),\(-87.604630)&q=\(restaurantModel.restaurants[restaurantModel.selectedRestaurant].nickname)")!) {
                             HStack {
                             Image("Apple Maps")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(height: 40)
                             Text("Apple Maps")
                             .font(.custom("Avenir-Medium", size: 18))
                             .foregroundColor(Color("ForegroundColor"))
                             }
                             }
                             Spacer()
                             Link(destination: URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(restaurantModel.restaurants[restaurantModel.selectedRestaurant].nickname)&travelmode=driving")!) {
                             HStack {
                             Image("Google Maps")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(height: 40)
                             Text("Google Maps")
                             .font(.custom("Avenir-Medium", size: 18))
                             .foregroundColor(Color("ForegroundColor"))
                             }
                             }
                             Spacer()
                             } */
                        }
                        else {
                            // Location is denied, so show button to enable it in settings
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
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.red)
                                        .frame(width: 225, height: 40)
                                    
                                    Label("Turn on Your Location", systemImage: "exclamationmark.triangle.fill")
                                        .font(.custom("AvenirNext-Medium", size: 18))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Your Meal
                    Group {
                        HStack {
                            Text("Your Meal")
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .padding(.vertical, 5)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        ForEach(cartModel.menuItems, id: \.id) { menuItem in
                            MenuItemCartRow(menuItem: menuItem) {
                                cartModel.removeFromCart(menuItem: menuItem)
                                // let _ = withAnimation(.easeInOut(duration: 0.3)) {
                                    // cartModel.menuItems.remove(at: indexOf(menuItem: menuItem))
                                // }
                            }
                        }
                    }
                    
                    // MARK: - Subtotal, Taxes, Donation, and Total
                    VStack(alignment: .leading) {
                        Divider()
                        
                        // MARK: - Subtotal
                        HStack {
                            Text("Subtotal (\(cartModel.menuItems.count) \(cartModel.menuItems.count == 1 ? "item" : "items"))")
                                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            Spacer()
                            Text("$\(String(format: "%.2f", cartModel.total))")
                                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                .font(.custom("AvenirNext-Bold", size: 16))
                        }
                        .padding(.bottom, 5)
                        
                        // MARK: - Tax (10.75%)
                        HStack {
                            Text("Taxes")
                                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            Spacer()
                            Text("$\(String(format: "%.2f", cartModel.total * 0.1075))")
                                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                .font(.custom("AvenirNext-Bold", size: 16))
                        }
                        .padding(.bottom, 5)
                        
                        // MARK: - ACCESS Donation
                        if isChecked {
                            HStack {
                                Text("ACCESS Donation")
                                
                                Button {
                                    //
                                } label: {
                                    Image(systemName: "info.circle")
                                        .renderingMode(.template)
                                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                }
                                
                                Spacer()
                                Text("$\(String(format: "%.2f", donation))")
                                    .font(.custom("AvenirNext-Bold", size: 16))
                            }
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            .padding(.bottom, 5)
                        }
                        
                        // MARK: - Total
                        HStack {
                            Text("Total")
                                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            Spacer()
                            Text("$\(String(format: "%.2f", cartModel.total * 1.1075 + donation))")
                                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                .font(.custom("AvenirNext-Bold", size: 16))
                        }
                        .padding(.bottom, 5)
                        
                        // MARK: - Round Up & Donate
                        VStack(alignment: .leading) {
                            
                            // MARK: Round Up and Donate
                            HStack {
                                Text("Round Up & Donate")
                                    .font(.custom("AvenirNext-Bold", size: 20))
                                    .textCase(.uppercase)
                                Button {
                                    //
                                } label: {
                                    Image(systemName: "info.circle")
                                        .renderingMode(.template)
                                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                }
                            }
                            
                            HStack {
                                Image("southside0")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 125, height: 125)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.trailing)
                                
                                VStack(alignment: .leading) {
                                    Text("ACCESS Initiative")
                                        .font(.custom("AvenirNext-Bold", size: 22))
                                        .textCase(.uppercase)
                                    Text("A Black-owned non-profit in Chicago's South Side fighting for better access to food for all of its citizens.")
                                }
                                
                                
                            }
                            
                            Text("\(Image(systemName: isChecked ? "checkmark.square.fill" : "square"))    Yes, I want to round up & donate!")
                                .padding(.top)
                                .onTapGesture {
                                    isChecked.toggle()
                                }
                            Text("100% of your donation will go toward the ACCESS Initative, and we'll match your donation too!")
                                .foregroundColor(.gray)
                                .font(.custom("AvenirNext-Medium", size: 14))
                                .padding(.top, 1)
                                .padding(.bottom)
                        }
                        .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                        .font(.custom("AvenirNext-Medium", size: 16))
                        
                        // MARK: - Bottom Buttons
                        /* Group {
                            // MARK: "Continue Ordering" Button
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(minWidth: 100, maxWidth: 400)
                                        .frame(height: 45)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                    
                                    Text("Continue Ordering")
                                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                        .font(.custom("AvenirNext-Medium", size: 18))
                                }
                            }
                            .buttonStyle(.plain)
                            .padding(.top)
                            
                            // MARK: "Pay" Button
                            Button {
                                payWithCard()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(minWidth: 100, maxWidth: 400)
                                        .frame(height: 45)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(5)
                                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                    
                                    Text("Pay ")
                                        .foregroundColor(.white)
                                        .font(.custom("AvenirNext-Medium", size: 18))
                                    +
                                    Text("$\(String(format: "%.2f", cartModel.total * 1.1075 + donation))")
                                        .foregroundColor(.white)
                                        .font(.custom("AvenirNext-Bold", size: 18))
                                }
                            }
                            .buttonStyle(.plain)
                            .padding(.top)
                            
                            // MARK: "Apple Pay" Button
                            PaymentButton(action: {})
                                .padding(.vertical)
                        } */
                    }
                    .font(.custom("AvenirNext-Medium", size: 16))
                    .padding(.horizontal)
                    
                    // MARK: Payment Method
                    Group {
                        Section(header: Text("Payment Info")) {
                            Text("Payment Method") // TODO: navigation menu to apple pay, saved cards, and "Add payment method"
                            STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
                            Text("Save payment method") // TODO: Make checkbox
                            Text("Set as default payment method") // TODO: Make checkbox and only show if above is checked
                        }
                    }
                    .padding(.horizontal)
                }
                
                // MARK: "Checkout" Button
                Button {
                    startCheckout { clientSecret in
                        PaymentConfig.shared.paymentIntentClientSecret = clientSecret
                        DispatchQueue.main.async {
                            isCheckingOut = true
                        }
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(minWidth: 100, maxWidth: 400)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(5)
                            .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                        
                        Text("Checkout ")
                            .foregroundColor(.white)
                            .font(.custom("AvenirNext-Medium", size: 18))
                        +
                        Text("(\(cartModel.menuItems.count) \(cartModel.menuItems.count == 1 ? "item" : "items"))")
                            .foregroundColor(.white)
                            .font(.custom("AvenirNext-Bold", size: 18))
                    }
                }
                .buttonStyle(.plain)
                .padding([.top, .horizontal])
                
                // MARK: "Apple Pay" Button
                PaymentButton(action: {})
                    .padding(.horizontal)
            }
            .safeAreaInset(edge: .top) {
                VStack {
                    HStack {
                        Text("Your Order")
                            .font(.custom("AvenirNext-Bold", size: 30))
                            //.textCase(.uppercase)
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .renderingMode(.template)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"), Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])")]), startPoint: .top, endPoint: .bottom)
                )
            }
            .navigationBarHidden(true)
            .background(Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
        }
    }
    
    func indexOf(menuItem: MenuItem) -> Int {
        if let index = cartModel.menuItems.firstIndex(where: { menuItem_ in
            menuItem.id == menuItem_.id
        }) {
            return index
        }
        return 0
    }
    
    private func startCheckout(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://chief-possible-quilt.glitch.me/create-payment-intent")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(cartModel.menuItems)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(nil)
                return
            }
            
            let checkoutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            completion(checkoutIntentResponse?.clientSecret)
        }
        .resume()
    }
    
    private func payWithCard() {
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in
            switch status {
            case .failed:
                message = "Failed"
            case .canceled:
                message = "Cancelled"
            case .succeeded:
                message = "Your payment has been successfully completed!"
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .environmentObject(MapModel())
            .environmentObject(AppSettingsModel())
            .colorScheme(.dark)
    }
}

extension View {
    func navigationBarTitle<Content>(
        @ViewBuilder content: () -> Content
    ) -> some View where Content : View {
        self.toolbar {
            ToolbarItem(placement: .principal, content: content)
        }
    }
}
