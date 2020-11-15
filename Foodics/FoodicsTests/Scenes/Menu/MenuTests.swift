//
//  MenuTests.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import Foodics

class MenuTests: BaseSceneTests {
  var sut: MenuViewModel!
  
  override func setUp() {
    super.setUp()
    sut = MenuViewModel(router: router)
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  
}
