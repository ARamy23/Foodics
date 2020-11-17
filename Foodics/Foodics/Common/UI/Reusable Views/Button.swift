//
//  Button.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

open class Button: UIButton {
  public enum TypeOfButton {
    case text(_ text: String, style: ButtonStyle)
    case icon(_ icon: UIImage, tintColor: UIColor?)
    case textWithLeadingIcon(_ text: String, icon: UIImage, style: ButtonStyle)
    case textWithTrailingIcon(_ text: String, icon: UIImage, style: ButtonStyle)
    
    var style: ButtonStyle? {
      switch self {
      case let .text(_, style: style),
           let .textWithLeadingIcon(_, icon: _, style: style),
           let .textWithTrailingIcon(_, icon: _, style: style):
        return style
      default:
        return nil
      }
    }
  }

  private enum Direction {
    case leading
    case trailing
  }

  public var type: TypeOfButton = .text(.empty, style: PrimaryButtonStyle()) {
    didSet {
      updateType()
    }
  }

  open override var isEnabled: Bool {
    didSet {
      updateType()
    }
  }

  open var imageToTitleSpacing: CGFloat {
    return 8
  }

  var extraContentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
  open override var contentEdgeInsets: UIEdgeInsets {
    get {
      return super.contentEdgeInsets
    }
    set {
      super.contentEdgeInsets = newValue
      extraContentEdgeInsets = newValue
    }
  }

  var extraImageEdgeInsets: UIEdgeInsets = .zero
  open override var imageEdgeInsets: UIEdgeInsets {
    get {
      return super.imageEdgeInsets
    }
    set {
      super.imageEdgeInsets = newValue
      extraImageEdgeInsets = newValue
    }
  }

  var extraTitleEdgeInsets: UIEdgeInsets = .zero
  open override var titleEdgeInsets: UIEdgeInsets {
    get {
      return super.titleEdgeInsets
    }
    set {
      super.titleEdgeInsets = newValue
      extraTitleEdgeInsets = newValue
    }
  }

  public init(type: TypeOfButton) {
    self.type = type
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

  open override func layoutSubviews() {
    if let imageSize = imageView?.image?.size,
      let font = titleLabel?.font,
      let textSize = titleLabel?.attributedText?.size() ?? titleLabel?.text?
      .size(withAttributes: [NSAttributedString.Key.font: font]) {
      var _imageEdgeInsets = UIEdgeInsets.zero
      var _titleEdgeInsets = UIEdgeInsets.zero
      var _contentEdgeInsets = UIEdgeInsets.zero

      let halfImageToTitleSpacing = imageToTitleSpacing / 2.0

      func adjustLeftSpacing() {
        _imageEdgeInsets.left = -halfImageToTitleSpacing
        _imageEdgeInsets.right = halfImageToTitleSpacing
        _titleEdgeInsets.left = halfImageToTitleSpacing
        _titleEdgeInsets.right = -halfImageToTitleSpacing
        _contentEdgeInsets.left = halfImageToTitleSpacing
        _contentEdgeInsets.right = halfImageToTitleSpacing
      }

      func adjustRightSpacing() {
        _imageEdgeInsets.left = textSize.width + halfImageToTitleSpacing
        _imageEdgeInsets.right = -textSize.width - halfImageToTitleSpacing
        _titleEdgeInsets.left = -imageSize.width - halfImageToTitleSpacing
        _titleEdgeInsets.right = imageSize.width + halfImageToTitleSpacing
        _contentEdgeInsets.left = halfImageToTitleSpacing
        _contentEdgeInsets.right = halfImageToTitleSpacing
      }

      switch type {
      case .text, .icon:
        _imageEdgeInsets = .zero
        _titleEdgeInsets = .zero
        _contentEdgeInsets = .zero

      case .textWithLeadingIcon:
        if UserSettingsService.shared.language.value?.isRTLLanguage ?? false {
          semanticContentAttribute = .forceRightToLeft
        } else {
          semanticContentAttribute = .forceLeftToRight
        }

      case .textWithTrailingIcon:
        if UserSettingsService.shared.language.value?.isRTLLanguage ?? false {
          semanticContentAttribute = .forceLeftToRight
        } else {
          semanticContentAttribute = .forceRightToLeft
        }
      }

      _contentEdgeInsets.top += extraContentEdgeInsets.top
      _contentEdgeInsets.bottom += extraContentEdgeInsets.bottom
      _contentEdgeInsets.left += extraContentEdgeInsets.left
      _contentEdgeInsets.right += extraContentEdgeInsets.right

      _imageEdgeInsets.top += extraImageEdgeInsets.top
      _imageEdgeInsets.bottom += extraImageEdgeInsets.bottom
      _imageEdgeInsets.left += extraImageEdgeInsets.left
      _imageEdgeInsets.right += extraImageEdgeInsets.right

      _titleEdgeInsets.top += extraTitleEdgeInsets.top
      _titleEdgeInsets.bottom += extraTitleEdgeInsets.bottom
      _titleEdgeInsets.left += extraTitleEdgeInsets.left
      _titleEdgeInsets.right += extraTitleEdgeInsets.right

      super.imageEdgeInsets = _imageEdgeInsets
      super.titleEdgeInsets = _titleEdgeInsets
      super.contentEdgeInsets = _contentEdgeInsets

    } else {
      super.imageEdgeInsets = extraImageEdgeInsets
      super.titleEdgeInsets = extraTitleEdgeInsets
      super.contentEdgeInsets = extraContentEdgeInsets
    }

    super.layoutSubviews()
  }
}

// MARK: - Private

private extension Button {
  func initialize() {
    contentVerticalAlignment = .fill
    contentHorizontalAlignment = .center
    titleLabel?.textAlignment = UILocalization.shared.textAlignment
    setTitle(nil, for: .normal)
    layer.cornerRadius = Dimensions.Buttons.cornerRadius
    layer.masksToBounds = true
    imageView?.contentMode = .scaleAspectFit
    adjustsImageWhenDisabled = false
    tintAdjustmentMode = .normal
    updateType()
  }

  func updateType() {
    self.backgroundColor = type.style?.backgroundColor
    self.borderColor = type.style?.borderColor
    self.borderWidth = type.style?.borderWidth ?? 0.0
    switch type {
    case let .text(text, style):
      setText(text, buttonStyle: style)

    case let .icon(icon, tintColor):
      setIcon(icon, tintColor: tintColor)

    case let .textWithLeadingIcon(text, icon, style):
      setText(text, buttonStyle: style)
      setIcon(icon, tintColor: style.iconColor)

    case let .textWithTrailingIcon(text, icon, style):
      setText(text, buttonStyle: style)
      setIcon(icon, tintColor: style.iconColor)
    }
  }

  func setText(_ text: String, buttonStyle: ButtonStyle) {
    UIView.performWithoutAnimation {
      setAttributedTitle(NSAttributedStringBuilder()
        .add(text: text)
        .add(foregroundColor: buttonStyle.textColor)
        .build(), for: .normal)
    }
  }

  func setIcon(_ icon: UIImage, tintColor: UIColor?) {
    guard let tintColor = tintColor else { return }
    UIView.animate(withDuration: 0.3) {
      self.setImage(icon.withTintColor(tintColor, renderingMode: .alwaysTemplate), for: .normal)
      self.tintColor = tintColor
    }
  }
}
