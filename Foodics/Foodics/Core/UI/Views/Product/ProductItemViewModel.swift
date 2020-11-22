//
//  ProductItemViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/22/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol ProductItemViewModelProtocol {
  var image: String { get set }
  var name: String { get set }
  var onTapAction: VoidCallback { get set }
}

public struct ProductItemViewModel: ProductItemViewModelProtocol {
  public var image: String
  public var name: String
  public var onTapAction: VoidCallback
  
  public init(image: String, name: String, onTapAction: @escaping VoidCallback) {
    self.image = image
    self.name = name
    self.onTapAction = onTapAction
  }
}
