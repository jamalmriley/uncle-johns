//
//  KeychainHelper.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/29/22.
//

import SwiftUI

// MARK: Keychain helper class
class KeychainHelper {
    
    // To access class data
    static let standard = KeychainHelper()
    
    // MARK: Saving Keychain value
    func save(data: Data, key: String, account: String) {
        
        // Creating query
        let query = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        // Adding data to Keychain
        let status = SecItemAdd(query, nil)
        
        // Checking for status
        switch status {
            // Success
        case errSecSuccess:
            print("Success")
            
            // Updating data
        case errSecDuplicateItem:
            let updateQuery = [
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            // Update field
            let updateAttr = [kSecValueData: data] as CFDictionary
            
            SecItemUpdate(updateQuery, updateAttr)
            
            // Otherwise error
        default: print("Error \(status)")
        }
    }
    
    // MARK: Reading Keychain Data
    func read(key: String, account: String) -> Data? {
        
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        // To copy the data
        var resultData: AnyObject?
        SecItemCopyMatching(query, &resultData)
        
        return (resultData as? Data)
    }
    
    // MARK: Deleting Keychain Data
    func delete(key: String, account: String) {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
