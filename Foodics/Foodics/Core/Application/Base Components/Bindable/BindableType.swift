//
//  BindableType.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public protocol BindableType: AnyObject {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindViewModel()
}

public extension BindableType where Self: UIViewController {
  func bind(to model: Self.ViewModelType) {
    viewModel = model
  }
}
