//
//  AuthModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

/*
import SwiftUI
import Firebase
import LocalAuthentication

class AuthModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Biometric Properties
    @AppStorage("use_biometrics") var useBiometrics: Bool = false
    
    // Keychain Properties
    @Keychain(key: "use_biometrics_email", account: "BiometricsLogin") var storedEmail
    @Keychain(key: "use_biometrics_password", account: "BiometricsLogin") var storedPassword
    
    // Login Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: Error
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    // MARK: Firebase Login
    func loginUser(useBiometrics: Bool, email: String = "", password: String = "") async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        
        DispatchQueue.main.async {
            
            // Storing once
            if useBiometrics && self.storedEmail == nil {
                self.useBiometrics = useBiometrics
                // MARK: Storing for future biometric login
                
                // Setting data is simple as @AppStorage
                let emailData = self.email.data(using: .utf8)
                let passwordData = self.password.data(using: .utf8)
                
                self.storedEmail = emailData
                self.storedPassword = passwordData
                // print("Stored")
            }
            
            self.checkLogin()
            self.getUserData()
        }
    }
    
    // MARK: Biometric Usage
    func getBiometricStatus() -> Bool {
        let scanner = LAContext()
        print(scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none))
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    // MARK: Biometric Login
    func authenticateUser() async throws {
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use your \(LAContext().biometryType == .faceID ? "face" : "fingerprint") to quickly log into the app!")
        
        if let emailData = storedEmail, let passwordData = storedPassword, status {
            try await loginUser(useBiometrics: useBiometrics, email: String(data: emailData, encoding: .utf8) ?? "", password: String(data: passwordData, encoding: .utf8) ?? "")
            getUserData()
        }
    }
    
    // MARK: Fetch user metadata
    func getUserData() {
        
        // Check that there's a logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // Get the meta data for user
        let db = Firestore.firestore()
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        ref.getDocument { snapshot, error in
            
            // Check for errors
            guard error == nil, snapshot != nil else {
                return
            }
            
            // Parse the data and set the user metadata
            let data = snapshot!.data()
            let user = UserService.shared.user
            user.firstName = data?["firstName"] as? String ?? ""
            user.lastName = data?["lastName"] as? String ?? ""
        }
    }
    
    // MARK: Check user login status
    func checkLogin() {
        
        // Check if there's a current user to determine logged in status
        logStatus = Auth.auth().currentUser != nil ? true : false
        
        // Check if user meta data has been fetched. If the user was already logged in ffrom  a prev session, we need to get their data in separate call
        if UserService.shared.user.firstName == "" {
            getUserData()
        }
    }
}
*/
