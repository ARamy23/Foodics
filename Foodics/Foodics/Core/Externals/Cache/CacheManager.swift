//
//  CacheManager.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

class CacheManager {
  private let storage: Storage
  private let decoder: JSONDecoder
  private let encoder: JSONEncoder
  
  init(
    storage: Storage,
    decoder: JSONDecoder = .init(),
    encoder: JSONEncoder = .init()
  ) {
    self.storage = storage
    self.decoder = decoder
    self.encoder = encoder
  }
  
  func fetch<T: Decodable>(_ type: T.Type, for key: StorageKey) throws -> T {
    let data = try storage.fetchValue(for: key)
    return try decoder.decode(type, from: data)
  }
  
  func save<T: Encodable>(_ value: T, for key: StorageKey) throws {
    let data = try encoder.encode(value)
    try storage.save(value: data, for: key)
  }
}
