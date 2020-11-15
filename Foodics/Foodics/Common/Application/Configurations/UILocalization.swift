//
//  UILocalization.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

public struct UILocalization {
  static let shared = UILocalization(isRTLLanguage: UserSettingsService.shared.language.value?.isRTLLanguage ?? false)
  public let isRTLLanguage: Bool

  public var writingDirection: NSWritingDirection {
    return isRTLLanguage ? .rightToLeft : .leftToRight
  }

  public var semanticContentAttribute: UISemanticContentAttribute {
    return isRTLLanguage ? .forceRightToLeft : .forceLeftToRight
  }
  
  public var textAlignment: NSTextAlignment {
    return isRTLLanguage ? .right : .left
  }
}
