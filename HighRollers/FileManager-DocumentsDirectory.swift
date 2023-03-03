//
//  FileManager-DocumentsDirectory.swift
//  HighRollers
//
//  Created by Edwin Przeźwiecki Jr. on 03/03/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        self.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
