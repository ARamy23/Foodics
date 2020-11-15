//
//  Dynamic.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation


/// Lightweight Observable Pattern
public class Dynamic<T> {
  
  private var bindings: [Callback<T>] = []
  
  public var value :T? {
    didSet {
      update()
    }
  }
  
  public init(_ v :T) {
    value = v
  }
  
  public func update() {
    guard let value = value else { return }
    bindings.forEach {
      $0(value)
    }
  }
  
  func subscribe(_ binding: @escaping Callback<T>) {
    self.bindings.append(binding)
  }
}
