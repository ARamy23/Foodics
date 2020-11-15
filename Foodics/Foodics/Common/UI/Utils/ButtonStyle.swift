//
//  ButtonStyle.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

public protocol ButtonStyle: Style {
  var iconColor: UIColor { get }
}

struct PrimaryButtonStyle: ButtonStyle {
  var textColor: UIColor {
    R.color.textButtonTextColor() ?? .red
  }
  
  var backgroundColor: UIColor {
    .clear
  }
  
  var iconColor: UIColor {
    .clear
  }
  
  var borderColor: UIColor? {
    nil
  }
  
  var borderWidth: CGFloat? {
    nil
  }
}
