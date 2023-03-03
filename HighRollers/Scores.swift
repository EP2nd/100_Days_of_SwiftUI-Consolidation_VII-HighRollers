//
//  Scores.swift
//  HighRollers
//
//  Created by Edwin Przeźwiecki Jr. on 03/03/2023.
//

import Foundation

struct Score: Codable, Comparable, Identifiable {
    var id = UUID()
    var record: Int
    
    static func <(lhs: Score, rhs: Score) -> Bool {
        rhs.record < lhs.record
    }
}
