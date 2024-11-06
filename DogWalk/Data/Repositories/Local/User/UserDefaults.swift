//
//  UserDefaults.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let storage: UserDefaults
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
           self.key = key
           self.defaultValue = defaultValue
           self.storage = storage
       }
    
    var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue}
        set { self.storage.set(newValue, forKey: self.key)}
    }
}
