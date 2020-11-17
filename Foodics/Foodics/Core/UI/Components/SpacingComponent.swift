//
//  SpacingComponent.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import Carbon

public struct SpacingComponent: IdentifiableComponent {
  
  private let height: CGFloat
  private let color: UIColor
  
  public var id: String {
    return "SpacingComponent"
  }
  
  public init(_ height: CGFloat, color: UIColor = .clear) {
    self.height = height
    self.color = color
  }
  
  public func renderContent() -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
  }
  
  public func render(in content: UIView) {
    content.backgroundColor = color
  }
  
  public func shouldRender(next: SpacingComponent, in content: UIView) -> Bool {
    return true
  }
  
  public func referenceSize(in bounds: CGRect) -> CGSize? {
    CGSize(width: bounds.width, height: height)
  }
}

