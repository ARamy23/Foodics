//
//  Configurable.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIView

public protocol ConfigurableProtocol {
  associatedtype ViewModelType
  func configure(with viewModel: ViewModelType)
}

public protocol Configurable: UIView, ConfigurableProtocol {}
