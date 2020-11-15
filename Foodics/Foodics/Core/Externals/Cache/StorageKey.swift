//
//  CachingKey.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

enum StorageKey: CaseIterable {
  case menu
  
  var key: String {
    switch self {
    case .menu:
      return "menu"
    }
  }
}
