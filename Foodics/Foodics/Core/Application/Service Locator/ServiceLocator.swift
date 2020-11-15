//
//  ServiceLocator.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

enum ServiceLocator {
  static var network: NetworkProtocol = MoyaManager()
  static var storage: Storage = DiskStorage()
  static var cacheManager = CacheManager(storage: storage)
}
