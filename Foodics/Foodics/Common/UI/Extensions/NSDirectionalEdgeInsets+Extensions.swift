//
//  NSDirectionalEdgeInsets+Extensions.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public extension NSDirectionalEdgeInsets {
  enum Edge {
    case top(CGFloat)
    case bottom(CGFloat)
    case leading(CGFloat)
    case leadingTop(leading: CGFloat, top: CGFloat)
    case trailingBottom(trailing: CGFloat, bottom: CGFloat)
    case trailing(CGFloat)
    case vertical(CGFloat)
    case horizontal(CGFloat)
    case all(CGFloat)
    case custom(leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat)
  }

  init(_ edge: Edge) {
    switch edge {
    case let .top(top):
      self.init(top: top, leading: .zero, bottom: .zero, trailing: .zero)
    case let .bottom(bottom):
      self.init(top: .zero, leading: .zero, bottom: bottom, trailing: .zero)
    case let .leading(leading):
      self.init(top: .zero, leading: leading, bottom: .zero, trailing: .zero)
    case let .trailing(trailing):
      self.init(top: .zero, leading: .zero, bottom: .zero, trailing: trailing)
    case let .vertical(vertical):
      self.init(top: vertical, leading: .zero, bottom: vertical, trailing: .zero)
    case let .horizontal(horizontal):
      self.init(top: .zero, leading: horizontal, bottom: .zero, trailing: horizontal)
    case let .leadingTop(leading, top):
      self.init(top: top, leading: leading, bottom: .zero, trailing: .zero)
    case let .trailingBottom(trailing, bottom):
      self.init(top: .zero, leading: .zero, bottom: bottom, trailing: trailing)
    case let .all(inset):
      self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    case let .custom(leading, trailing, top, bottom):
      self.init(top: top, leading: leading, bottom: bottom, trailing: trailing)

    }
  }
}
