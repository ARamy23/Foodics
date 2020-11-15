//
//  CacheMock.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

@testable import Foodics

final class CacheMock: CacheProtocol {
    var dataStorage: [CachingKey: Any] = [:]
    
    func getBool(key: CachingKey) -> Bool? {
        return dataStorage[key] as? Bool
    }
    
    func saveBool(value: Bool, key: CachingKey) {
        dataStorage[key] = value
    }
    
    func saveData(_ data: Data, key: CachingKey) {
        dataStorage[key] = data
    }
    
    func getObject<T>(_ object: T.Type, key: CachingKey) -> T? where T : Decodable, T : Encodable {
        return dataStorage[key] as? T
    }
    
    func getData(key: CachingKey) -> [Data]? {
        return (dataStorage[key] as? Data).map({[$0]})
    }
    
    func saveData(_ data: Data?, key: CachingKey) {
        dataStorage[key] = data
    }
    
    func getObject<T>(_ object: T, key: CachingKey) -> T? {
        return dataStorage[key] as? T
    }
    
    func saveObject<T>(_ object: T, key: CachingKey) {
        dataStorage[key] = object
    }
    
    func removeObject(key: CachingKey) {
        dataStorage.removeValue(forKey: key)
    }
    
    func flushCache() {
        dataStorage.removeAll()
    }
}
