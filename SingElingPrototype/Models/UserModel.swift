//
//  NameModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 29/10/24.
//

import Foundation

struct Defaults {
    
    private static let nameKey = "name"
    
    static func save(name: String) {
        UserDefaults.standard.set(name, forKey: nameKey)
    }
    
    static func getName() -> String {
        return UserDefaults.standard.string(forKey: nameKey) ?? ""
    }
    
    static func clearName() {
        UserDefaults.standard.removeObject(forKey: nameKey)
    }
    
    static var isNameSaved: Bool {
        return !getName().isEmpty
    }
}
