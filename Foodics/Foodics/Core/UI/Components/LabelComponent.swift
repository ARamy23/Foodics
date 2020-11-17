//
//  LabelComponent.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/17/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon

public struct LabelComponent: IdentifiableComponent {
  
  public var id: String {
    return "LabelComponent"
  }
  
  private var text: String?
  private var color: UIColor?
  private var font: UIFont?
  private var isCentered: Bool?
  private var backgroundColor: UIColor?

  private var attributedText: NSAttributedString?
  
  public init(text: String, color: UIColor = .black, font: UIFont = TextStyles.body,
              isCentered: Bool = false, backgroundColor: UIColor = .white) {
    self.text = text
    self.color = color
    self.font = font
    self.isCentered = isCentered
    self.backgroundColor = backgroundColor
  }
  
  public init(attributedText: NSAttributedString) {
    self.attributedText = attributedText
  }
  
  public func shouldRender(next: LabelComponent, in content: Label) -> Bool {
    return true
  }

  public func renderContent() -> Label {
    let content = Label()
    content.edgeInsets = .init(top: 0, left: Configurations.UI.Spacing.p3, bottom: 0, right: Configurations.UI.Spacing.p3)
    content.backgroundColor = backgroundColor ?? .clear
    return content
  }

  public func render(in content: Label) {
    if let text = text {
      if let color = color, let font = font {
        content.textColor = color
        content.font = font
      }
      
      if isCentered == true {
        content.textAlignment = .center
      } else {
        content.textAlignment = UILocalization.shared.textAlignment
      }
      
      content.text = text
    } else {
      content.attributedText = attributedText
    }
  }
}
