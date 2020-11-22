//
//  CachingKey.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

public enum StorageKey: CaseIterable {
  case menu
  
  var key: String {
    switch self {
    case .menu:
      return "menu"
    }
  }
}
