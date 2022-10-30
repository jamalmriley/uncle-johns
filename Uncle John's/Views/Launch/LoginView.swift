//
//  LoginView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/29/22.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @EnvironmentObject var authModel: AuthModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var showPassword: Bool = false
    
    // MARK: Biometric Properties
    @State var useBiometrics: Bool = false
    
    var body: some View {
        VStack {
            Image("Uncle John's Barbeque Icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            // MARK: Login Text Fields
            Group {
                // MARK: Email Address
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.3)
                        .frame(width: 25, height: 25)
                    
                    CustomLoginField(placeholder: Text("Email Address"), text: $authModel.email)
                        .keyboardType(.emailAddress)
                        .font(.custom("AvenirNext-Medium", size: 16))
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(Color("TextField"))
                .cornerRadius(50)
                .padding(.bottom)
                
                // MARK: Password
                HStack {
                    Image(systemName: "key")
                        .foregroundColor(.black)
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.3)
                        .frame(width: 25, height: 25)
                    
                    Group {
                        if showPassword {
                            CustomLoginField(placeholder: Text("Password"), text: $authModel.password)
                        } else {
                            CustomPasswordField(placeholder: Text("Password"), text: $authModel.password)
                        }
                    }
                    .font(.custom("AvenirNext-Medium", size: 16))
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(Color("TextField"))
                .cornerRadius(50)
            }
            
            HStack {
                Spacer()
                
                // MARK: Standard Login
                Button {
                    Task {
                        do {
                            try await authModel.loginUser(useBiometrics: useBiometrics)
                        }
                        catch {
                            authModel.errorMsg = error.localizedDescription
                            authModel.showError.toggle()
                        }
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .foregroundColor(Color("AccentColor (UJB)"))
                            .frame(width: 125, height: 50)
                        
                        Text("Log In")
                            .font(.custom("AvenirNext-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.plain)
                .disabled(authModel.email == "" || authModel.password == "")
                
                // MARK: Biometric Login
                if authModel.getBiometricStatus() && authModel.useBiometrics {
                    Spacer()
                    
                    Button {
                        Task {
                            do {
                                try await authModel.authenticateUser()
                            }
                            catch {
                                authModel.errorMsg = error.localizedDescription
                                authModel.showError.toggle()
                            }
                        }
                    } label: {
                        ZStack {
                            Capsule()
                                .stroke(Color("ForegroundColor"), lineWidth: 2)
                                .frame(width: 125, height: 50)
                            
                            HStack {
                                Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                
                                Text(String(LAContext().biometryType == .faceID ? "Face ID" : "Touch ID"))
                                    .font(.custom("AvenirNext-Medium", size: 16))
                            }
                            .foregroundColor(Color("ForegroundColor"))
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
            .padding(.vertical, 20)
            
            if authModel.getBiometricStatus() && !authModel.useBiometrics {
                Toggle(isOn: $useBiometrics) {
                    Text("Enable \(LAContext().biometryType == .faceID ? "Face ID" : "Touch ID")")
                        .foregroundColor(.gray)
                }
            }
            
            Text("Forgot password?")
                .font(.custom("AvenirNext-Medium", size: 18))
                .foregroundColor(.white)
            
            Spacer()
            
            Group {
                HStack{
                    Text("Don't have an account?")
                    Text("Sign up!")
                        .bold()
                }
                .font(.custom("AvenirNext-Medium", size: 18))
                .foregroundColor(.white)
                
                NavigationLink {
                    // Detect the authorization status of geolocating the user
                    if restaurantModel.authorizationState == .notDetermined {
                        OnboardingView() // If location is not determined, show OnboardingView.
                    }
                    else if restaurantModel.authorizationState == .authorizedAlways || restaurantModel.authorizationState == .authorizedWhenInUse {
                        BaseView() // If approved, show the BaseView.
                    }
                    else {
                        LocationDeniedView() // If denied, show LocationDeniedView.
                    }
                } label: {
                    Text("Skip for now")
                        .font(.custom("AvenirNext-Medium", size: 16))
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal)
        .background(PatternBackground())
        .alert(authModel.errorMsg, isPresented: $authModel.showError) {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthModel())
            .environmentObject(RestaurantModel())
    }
}
