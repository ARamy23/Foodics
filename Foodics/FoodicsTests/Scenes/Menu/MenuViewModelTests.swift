//
//  MenuTests.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import Foodics

class MenuViewModelTests: BaseSceneTests {
  var sut: MenuViewModel!
  var model: MenuModel!
  
  override func setUp() {
    super.setUp()
    model = MenuModel()
    sut = MenuViewModel(router: router, model: model)
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    model = nil
  }
  
  func testWhenMenuViewWillAppearAndModelReturnsDataItShowsUpOnUI() {
    // Given
    var dummyCategory1 = MenuCategoriesResponse.Data()
    dummyCategory1.name = "Dum Dum"
    var dummyCategory2 = MenuCategoriesResponse.Data()
    dummyCategory2.name = "Dum Dum"
    let expectedResponseFromNetwork = MenuCategoriesResponse(data: [dummyCategory1, dummyCategory2], links: nil, meta: nil)
    network.object = expectedResponseFromNetwork
    
    // When
    sut.viewWillAppear()
    
    // Then
    XCTAssertTrue(sut.sections.value?.isEmpty == false)
  }
  
  func testAWhenMenuViewWillAppearAndModelReturnsEmptyDataItShowsUpEmptyStateViewOnUI() {
    // Given
    let expectedResponseFromNetwork = MenuCategoriesResponse(data: [], links: nil, meta: nil)
    network.object = expectedResponseFromNetwork
    
    // When
    sut.viewWillAppear()
    
    // Then
    XCTAssertTrue(sut.sections.value?.first?.cells.first?.component(as: EmptyStateComponent.self) != nil)
  }
  
  func testWhenMenuModelIsInFirstPageThenLoadPreviousPageButtonDoesntShow() {
    // Given
    model.page = 1
    var dummyCategory1 = MenuCategoriesResponse.Data()
    dummyCategory1.name = "Dum Dum"
    var dummyCategory2 = MenuCategoriesResponse.Data()
    dummyCategory2.name = "Dum Dum"
    let expectedResponseFromNetwork = MenuCategoriesResponse(data: [dummyCategory1, dummyCategory2], links: nil, meta: nil)
    network.object = expectedResponseFromNetwork
    
    // When
    sut.viewWillAppear()
    
    // Then
    XCTAssertTrue(sut.sections.value?.first?.cells.first?.component(as: ButtonComponent.self) == nil)
  }
}
