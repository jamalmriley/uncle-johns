//
//  KeychainPropertyWrapper.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/29/22.
//

import SwiftUI

// MARK: Custom Wrapper For Keychain
// For easy use

@propertyWrapper

struct Keychain: DynamicProperty {
    
    @State var data: Data?
    
    var wrappedValue: Data? {
        get { KeychainHelper.standard.read(key: key, account: account) }
        nonmutating set {
            
            guard let newData = newValue else {
                // If we set data to nil
                // Simply delete the keychain data
                data = nil
                KeychainHelper.standard.delete(key: key, account: account)
                return
            }
            
            // Updating or setting keychain data
            KeychainHelper.standard.save(data: newData, key: key, account: account)
            
            // Updating data
            data = newValue
        }
    }
    
    var key: String
    var account: String
    
    init(key: String, account: String) {
        self.key = key
        self.account = account
        
        // Setting initial state keychain data
        _data = State(wrappedValue: KeychainHelper.standard.read(key: key, account: account))
    }
}
