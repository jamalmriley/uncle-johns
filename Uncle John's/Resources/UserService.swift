//
//  UserService.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/29/22.
//

import Foundation

class UserService {
    
    var user = User()
    static var shared = UserService()
    private init() {
        
    }
}
