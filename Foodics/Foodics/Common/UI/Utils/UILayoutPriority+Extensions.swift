//
//  UILayoutPriority+Extensions.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/4/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

public extension UILayoutPriority {

  static func rawValue(_ value: Float) -> UILayoutPriority  {
    return UILayoutPriority(value)
  }
}
