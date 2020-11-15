//
//  NetworkMock.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

@testable import Foodics

final class NetworkMock: NetworkProtocol {
  
  var didRemoveOldRequests: Bool = false
  var calledAPIs = [Endpoint]()
  var object: Codable?
  var objects: [Codable]?
  var error: Error?
  var shouldWait = false
  var continueAction: (() -> Void)?
  var didCallNetwork: Bool {
    return calledAPIs.count > 0
  }
  
  func removePreviousCall() {
    didRemoveOldRequests = true
  }
  
  func call<T: Codable, U: Endpoint>(api: U, model: T.Type, _ onFetch: @escaping (Result<T, Error>) -> Void) {
    calledAPIs.append(api)
    if shouldWait {
      continueAction = {
        if self.objects?.isEmpty == false, let object = self.objects?.removeFirst() as? T {
          onFetch(.success(object))
        } else if let object = self.object as? T {
          onFetch(.success(object))
        } else {
          onFetch(.failure(self.error ?? LocalError.genericError))
        }
      }
    } else {
      if self.objects?.isEmpty == false, let object = self.objects?.removeFirst() as? T {
        onFetch(.success(object))
      } else if let object = self.object as? T {
        onFetch(.success(object))
      } else {
        onFetch(.failure(self.error ?? LocalError.genericError))
      }
    }
  }
  
  init() { }
  
  init(error: Error) {
    self.error = error
  }
  
  init(object: Codable) {
    self.object = object
  }
}

