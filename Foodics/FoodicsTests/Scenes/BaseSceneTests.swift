//
//  BaseSceneTests.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 10/17/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import XCTest

@testable import Foodics

class BaseSceneTests: XCTestCase {
  
  var network: NetworkMock!
  var router: RouterMock!
  var cache: CacheMock!
  
  override func setUp() {
    super.setUp()
    network = NetworkMock()
    router = RouterMock()
    cache = CacheMock()
    
    ServiceLocator.cache = cache
    ServiceLocator.keychain = cache
    ServiceLocator.network = network
  }
  
  override func tearDown() {
    super.tearDown()
    network = nil
    router = nil
    cache = nil
  }
}
