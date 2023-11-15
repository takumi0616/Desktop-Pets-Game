//
//  Item.swift
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
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
