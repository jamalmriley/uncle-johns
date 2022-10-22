//
//  Card.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/21/22.
//

import Foundation

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var isRotated: Bool = false
    var extraOffset: CGFloat = 0
    var scale: CGFloat = 1
    var zIndex: Double = 0
}
