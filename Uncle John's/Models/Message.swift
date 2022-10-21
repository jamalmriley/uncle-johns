//
//  Message.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/20/22.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
