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
  var cache: DiskStorageMock!
  
  override func setUp() {
    super.setUp()
    network = NetworkMock()
    router = RouterMock()
    cache = DiskStorageMock()
    
    ServiceLocator.shared = ServiceLocator(
      network: network,
      storage: cache
    )
  }
  
  override func tearDown() {
    super.tearDown()
    network = nil
    router = nil
    cache = nil
    
    ServiceLocator.shared = nil
  }
}
