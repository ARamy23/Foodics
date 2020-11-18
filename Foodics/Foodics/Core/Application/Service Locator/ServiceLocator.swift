//
//  ServiceLocator.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

final class ServiceLocator {
  
  static var shared: ServiceLocator!
  
  init(network: NetworkProtocol, storage: Storage) {
    self.network = network
    self.storage = storage
    self.cacheManager = CacheManager(storage: storage)
  }
  
  var network: NetworkProtocol
  var storage: Storage
  var cacheManager: CacheManager
}
