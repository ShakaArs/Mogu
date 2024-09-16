//
//  Item.swift
//  MoGu
//
//  Created by MacBook Air on 13/09/24.
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
