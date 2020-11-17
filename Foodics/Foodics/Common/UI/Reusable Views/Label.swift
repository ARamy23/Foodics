//
//  Label.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/17/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

@IBDesignable
open class Label: UILabel {
  @objc open dynamic var edgeInsets = UIEdgeInsets.zero {
    didSet {
      setNeedsLayout()
      invalidateIntrinsicContentSize()
    }
  }
  
  var customTextColor: UIColor? {
    didSet {
      text(text)
    }
  }
  
  var customFont: UIFont? {
    didSet {
      text(text)
    }
  }
  
  var customAttributedString: NSAttributedString? {
    didSet {
      text(text)
    }
  }
  
  // MARK: - Initializers

  public init(font: UIFont, color: UIColor) {
    self.customTextColor = color
    self.customFont = font
    super.init(frame: .zero)
    initialize()
  }
  
  public init(customAttributedString: NSAttributedString) {
    self.customAttributedString = customAttributedString
    super.init(frame: .zero)
    initialize()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  override open func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: edgeInsets))
  }

  override open var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + edgeInsets.left + edgeInsets.right,
                  height: size.height + edgeInsets.top + edgeInsets.bottom)
  }
}

private extension Label {
  func initialize() {
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    textAlignment = UILocalization.shared.textAlignment
    backgroundColor = .clear
  }
}

public extension Label {
  func text(_ text: String?) {
    // Clear text
    self.text = nil

    if let text = text, let customFont = customFont, let customTextColor = customTextColor {
      attributedText = NSAttributedStringBuilder()
        .add(text: text)
        .add(font: customFont)
        .add(foregroundColor: customTextColor)
        .build()
    } else if let customAttributedString = customAttributedString {
      attributedText = customAttributedString
    } else {
      attributedText = nil
    }
  }

  func hidableText(_ text: String?) {
    guard let text = text else {
      isHidden = true
      return
    }
    isHidden = false
    self.text(text)
  }
}
