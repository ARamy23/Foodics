//
//  BaseModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public class BaseModel {
  var cache: CacheManager
  var network: NetworkProtocol
  
  init(
    cache: CacheManager = ServiceLocator.shared.cacheManager,
    network: NetworkProtocol = ServiceLocator.shared.network) {
    self.cache = cache
    self.network = network
  }
}
