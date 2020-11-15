//
//  UserDefaultsManager.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation
import KeychainSwift

struct UserDefaultsManager: CacheProtocol {
  func getBool(key: CachingKey) -> Bool? {
    UserDefaults.standard.bool(forKey: key.key)
  }
  
  func saveBool(value: Bool, key: CachingKey) {
    UserDefaults.standard.set(value, forKey: key.key)
  }
  
  func getObject<T>(_ object: T.Type, key: CachingKey) -> T? where T : Decodable, T : Encodable {
    if object is String.Type {
      return getString(key: key) as? T
    } else {
      return getData(key: key)?[0].decode(object)
    }
  }
  
  func saveObject<T>(_ object: T, key: CachingKey) where T : Decodable, T : Encodable {
    if object is String {
      saveString(object as! String, key: key)
    } else {
      saveData(object.encode(), key: key)
    }
  }
  
  private func getString(key: CachingKey) -> String? {
    return UserDefaults.standard.string(forKey: key.key)
  }
  
  func getData(key: CachingKey) -> [Data]? {
    return UserDefaults.standard.data(forKey: key.key).map({[$0]})
  }
  
  private func saveString(_ object: String, key: CachingKey) {
    UserDefaults.standard.set(object, forKey: key.key)
  }
  
  func saveData(_ data: Data, key: CachingKey) {
    UserDefaults.standard.set(data, forKey: key.key)
  }
  
  func removeObject(key: CachingKey) {
    UserDefaults.standard.removeObject(forKey: key.key)
  }
  
  func flushCache() {
    CachingKey.allCases
      .filter { !$0.shouldBeFilteredFromInvalidation }
      .forEach { self.removeObject(key: $0) }
  }
}

final class KeychainManager: CacheProtocol {
  
  lazy var keychain = KeychainSwift()
  
  func getData(key: CachingKey) -> [Data]? {
    keychain.getData(key.key).map { [$0] }
  }
  
  func saveData(_ data: Data, key: CachingKey) {
    keychain.set(data, forKey: key.key)
  }
  
  func getObject<T>(_ object: T.Type, key: CachingKey) -> T? where T : Decodable, T : Encodable {
    if object is String.Type {
      return getString(key: key) as? T
    } else {
      return getData(key: key)?[0].decode(object)
    }
  }
  
  func saveObject<T>(_ object: T, key: CachingKey) where T : Decodable, T : Encodable {
    if object is String {
      saveString(object as! String, key: key)
    } else {
      saveData(object.encode(), key: key)
    }
  }
  
  private func getString(key: CachingKey) -> String? {
    keychain.get(key.key)
  }

  private func saveString(_ object: String, key: CachingKey) {
    keychain.set(object, forKey: key.key)
  }
  
  func getBool(key: CachingKey) -> Bool? {
    keychain.getBool(key.key)
  }
  
  func saveBool(value: Bool, key: CachingKey) {
    keychain.set(value, forKey: key.key)
  }
  
  func removeObject(key: CachingKey) {
    keychain.delete(key.key)
  }
  
  func flushCache() {
    CachingKey.allCases
      .filter { !$0.shouldBeFilteredFromInvalidation }
      .forEach { self.removeObject(key: $0) }
  }
  
  private static let tokenKey = "access-token"
  
  static var userToken: String? {
    get {
      let keychain = KeychainSwift()
      return keychain.get(tokenKey)
    }set {
      let keychain = KeychainSwift()
      if let value = newValue {
        keychain.set(value, forKey: tokenKey)
      } else {
        keychain.delete(tokenKey)
      }
    }
  }
  
  static var doesTokenExist: Bool {
    let keychain = KeychainSwift()
    return keychain.get(tokenKey) != nil
  }
  
  static func deleteToken() {
    let keychain = KeychainSwift()
    keychain.delete(tokenKey)
  }
}
