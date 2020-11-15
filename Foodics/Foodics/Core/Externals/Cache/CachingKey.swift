//
//  CachingKey.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

enum CachingKey: CaseIterable {
  case user
  case token
  case email
  case password
  
  var key: String {
    switch self {
    case .user:
      return "user"
    case .token:
      return "token"
    case .email:
      return "email"
    case .password:
      return "password"
    }
  }
  
  var shouldBeFilteredFromInvalidation: Bool {
    return false
  }
}
