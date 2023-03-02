//
//  Dice.swift
//  HighRollers
//
//  Created by Edwin Przeźwiecki Jr. on 01/03/2023.
//

import Foundation

struct Dice: Codable {
    let amount: Int
    let type: Int
    
    static let example = Dice(amount: 6, type: 6)
}
