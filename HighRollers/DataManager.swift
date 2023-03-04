//
//  DataManager.swift
//  HighRollers
//
//  Created by Edwin Przeźwiecki Jr. on 03/03/2023.
//

import Foundation

struct DataManager {
    
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("HighRollers.json")
    
    static func save<T: Codable>(data: [T]) {
        if let encoded = try? JSONEncoder().encode(data) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    static func load() -> [Score] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Score].self, from: data) {
                return decoded
            }
        }
        
        return []
    }
}
