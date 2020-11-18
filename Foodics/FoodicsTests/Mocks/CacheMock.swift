//
//  CacheMock.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

@testable import Foodics

final class DiskStorageMock: Storage {
  var dataStorage: [StorageKey: Any] = [:]
  
  private var checkedKeysInStorage: [StorageKey] = []
  
  func fetchValue(for key: StorageKey) throws -> Data {
    checkedKeysInStorage.append(key)
    guard let data = dataStorage[key] as? Data else { throw StorageError.notFound }
    return data
  }
  
  func fetchValue(for key: StorageKey, handler: @escaping Handler<Data>) {
    checkedKeysInStorage.append(key)
    guard let data = dataStorage[key] as? Data else { handler(.failure(StorageError.notFound)); return }
    handler(.success(data))
  }
  
  func save(value: Data, for key: StorageKey) throws {
    dataStorage[key] = value
  }
  
  func save(value: Data, for key: StorageKey, handler: @escaping Handler<Data>) {
    dataStorage[key] = value
  }
  
  func didCheckForKeyInCache(_ key: StorageKey) -> Bool {
    return checkedKeysInStorage.contains(key)
  }
  
  func didCacheSomethingForKey(_ key: StorageKey) -> Bool {
    return dataStorage[key] != nil
  }
}
