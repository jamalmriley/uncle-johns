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
                TextField("Email Address", text: $authModel.email)
                    .padding()
                    .background {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("BackgroundColor"))
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 2)
                        }
                    }
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $authModel.password)
                    .padding()
                    .background {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("BackgroundColor"))
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 2)
                        }
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
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
