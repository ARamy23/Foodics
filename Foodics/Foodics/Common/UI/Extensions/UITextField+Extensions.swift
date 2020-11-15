//
//  UITextField+Extensions.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UITextField

public extension UITextField {
  enum Direction {
    case right
    case left
  }
  
  enum State: Equatable {
    case inactive
    case focused
    case error(message: String?)
    case disabled
  }
  
  func accessoryView(direction: Direction, view: UIView) {
    let topOffset = (Dimensions.TextFields.textFieldHeight - Dimensions.TextFields.iconSize.height) / 2
    let leftOffset = (Dimensions.TextFields.accessoryWidth - Dimensions.TextFields.iconSize.width) / 2
    view.frame = CGRect(x: leftOffset - 5, y: topOffset,
                        width: Dimensions.TextFields.iconSize.width,
                        height: Dimensions.TextFields.iconSize.height)

    let accessoryContainerView = UIView(frame: CGRect(x: 0, y: 0,
                                                      width: Dimensions.TextFields.accessoryWidth,
                                                      height: Dimensions.TextFields.textFieldHeight))
    accessoryContainerView.addSubview(view)

    if direction == .left {
      leftView = accessoryContainerView
      leftViewMode = .always
    } else {
      rightView = accessoryContainerView
      rightViewMode = .always
    }
  }

  func icon(direction: Direction, image: UIImage, tintColor: UIColor, action: VoidCallback? = nil) {
    let button = UIButton(type: .system).then {
      $0.setImage(image, for: .normal)
      $0.tintColor = tintColor
      if action != nil {
        $0.setControlEvent(.touchUpInside) {
          action?()
        }
      }
    }

    accessoryView(direction: direction, view: button)
  }

  func removeAccessoryView(direction: Direction) {
    if direction == .left {
      leftView = nil
      leftViewMode = .never
    } else {
      rightView = nil
      rightViewMode = .never
    }
  }
}
