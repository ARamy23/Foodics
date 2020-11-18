//
//  MenuModelTests.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 11/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import Foodics

class MenuModelTests: BaseSceneTests {
  var sut: MenuModel!
  
  override func setUp() {
    super.setUp()
    sut = MenuModel()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  func testWhenFetchingCategoriesAndItsFirstPageItChecksCategoriesInCache() {
    // Given
    sut.page = 1
    
    // When
    sut.fetchMenu(onFetch: { _ in })
    
    // Then
    XCTAssertTrue(cache.didCheckForKeyInCache(.menu))
  }
  
  func testWhenFetchingCategoriesAndItsNotFirstPageItDoesntCheckCategoriesInCache() {
    // Given
    sut.page = 2
    
    // When
    sut.fetchMenu(onFetch: { _ in })
    
    // Then
    XCTAssertFalse(cache.didCheckForKeyInCache(.menu))
  }
  
  func testWhenFetchingCategoriesAndItsFirstPageAndThereIsCategoriesCachedItReturnsThisCachedDataRatherThanFetchingThemFromTheServer() {
    // Given
    sut.page = 1
    let dummyCacheData = [MenuCategoriesResponse.Data().then { $0.id = "1" },
                          MenuCategoriesResponse.Data().then { $0.id = "2" },
                          MenuCategoriesResponse.Data().then { $0.id = "3" }]
    try! ServiceLocator.shared.cacheManager.save(dummyCacheData, for: .menu)
    
    // When
    sut.fetchMenu(onFetch: { result in
      let returnedData = try! result.get()
      XCTAssertEqual(returnedData, dummyCacheData)
    })
    
    // Then
    XCTAssertFalse(network.didCallNetwork)
  }
  
  func testWhenFetchingCategoriesAndItsFirstPageAndThereIsNoCachedDataItFetchesFromTheServer() {
    // Given
    sut.page = 1
    cache.dataStorage[.menu] = nil
    let dummyRemoteData = [MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data()]
    network.objects = [MenuCategoriesResponse(data: dummyRemoteData, links: nil, meta: nil)]
    
    // When
    sut.fetchMenu { (result) in
      let returnedData = try! result.get()
      XCTAssertEqual(dummyRemoteData, returnedData)
    }
    
    // Then
    XCTAssertTrue(network.didCallNetwork)
  }
  
  func testWhenFetchingCategoriesAndItsNotFirstPageThenFetchedDataIsNotCached() {
    // Given
    sut.page = 2
    let dummyRemoteData = [MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data()]
    network.objects = [MenuCategoriesResponse(data: dummyRemoteData, links: nil, meta: nil)]
    
    // When
    sut.fetchMenu { _ in }
    
    // Then
    XCTAssertFalse(cache.didCacheSomethingForKey(.menu))
  }
  
  func testWhenFetchingCategoriesAndItsFirstPageThenFetchedDataIsCached() {
    // Given
    sut.page = 1
    let dummyRemoteData = [MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data()]
    network.objects = [MenuCategoriesResponse(data: dummyRemoteData, links: nil, meta: nil)]
    
    // When
    sut.fetchMenu { _ in }
    
    // Then
    XCTAssertTrue(cache.didCacheSomethingForKey(.menu))
  }
  
  func testWhenFetchingPreviousCategoriesPageAndItsFirstPageThenItDoesntFetchAnything() {
    // Given
    sut.page = 1
    
    // When
    sut.fetchPreviousPage { _ in }
    
    // Then
    XCTAssertFalse(network.didCallNetwork)
  }
  
  func testWhenFetchingPreviousCategoriesPageAndItsNotFirstPageThenNetworkGetsCalled() {
    // Given
    sut.page = 2
    
    // When
    sut.fetchPreviousPage { _ in }
    
    // Then
    XCTAssertTrue(network.didCallNetwork)
  }
  
  func testWhenFetchingCategoriesPageGetsIncrementedAfterNetworkRequestIsDone() {
    // Given
    let initialPage = 1
    sut.page = initialPage
    let dummyRemoteData = [MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data()]
    network.objects = [MenuCategoriesResponse(data: dummyRemoteData, links: nil, meta: nil)]
    
    // When
    sut.fetchMenu { _ in }

    // Then
    XCTAssertGreaterThan(self.sut.page, initialPage)
  }
  
  func testWhenRefreshingCategoriesPageDoesntGetIncrementedAfterNetworkRequestIsDone() {
    // Given
    let initialPage = 1
    sut.page = initialPage
    let dummyRemoteData = [MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data(), MenuCategoriesResponse.Data()]
    network.objects = [MenuCategoriesResponse(data: dummyRemoteData, links: nil, meta: nil)]
    
    // When
    sut.refreshMenu { _ in }
    
    // Then
    XCTAssertEqual(sut.page, initialPage)
  }
}
