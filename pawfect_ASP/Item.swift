//
//  Item.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 10/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
