//
//  BaseViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/17/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

class BaseViewModel {
  var router: RouterProtocol
  var cache: CacheProtocol
  var network: NetworkProtocol
  
  init(
    router: RouterProtocol,
    cache: CacheProtocol = ServiceLocator.cache,
    network: NetworkProtocol = ServiceLocator.network) {
    self.router = router
    self.cache = cache
    self.network = network
  }
}
