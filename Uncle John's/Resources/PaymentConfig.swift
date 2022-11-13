//
//  PaymentConfig.swift
//  Uncle John's
//
//  Created by Jamal Riley on 11/13/22.
//

import Foundation

class PaymentConfig {
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() {
        
    }
}
