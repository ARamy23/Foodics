//
//  UIView+Extensions.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
  func roundCornersWithMask(_ corners: CACornerMask, radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = corners
  }
  
  var safeArea: ConstraintBasicAttributesDSL {
      
      #if swift(>=3.2)
          if #available(iOS 11.0, *) {
              return self.safeAreaLayoutGuide.snp
          }
          return self.snp
      #else
          return self.snp
      #endif
  }
  
  class func spacingView() -> UIView {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.setContentHuggingPriority(.rawValue(249), for: .horizontal)
    view.setContentHuggingPriority(.rawValue(249), for: .vertical)
    view.backgroundColor = .clear

    return view
  }
}

extension CACornerMask {
    public static var topLeading: CACornerMask { return .layerMinXMinYCorner }

    public static var topTrailing: CACornerMask { return .layerMaxXMinYCorner }

    public static var bottomLeading: CACornerMask { return .layerMinXMaxYCorner }

    public static var bottomTrailing: CACornerMask { return .layerMaxXMaxYCorner }
}
