//
//  Models.swift
//  AlarmApp-jan2025
//
//  Created by mac on 28/01/25.
//

import Foundation

// MARK: - Alarm Model
struct Alarm: Identifiable, Codable {
    var id = UUID()
    var time: Date
    var isEnabled: Bool
}



// MARK: - UserDefaults Extensions for Codable Storage
extension UserDefaults {
    func save<T: Codable>(_ object: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            set(encoded, forKey: key)
        }
    }

    func load<T: Codable>(key: String, type: T.Type) -> T? {
        if let savedData = data(forKey: key) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: savedData)
        }
        return nil
    }
}
