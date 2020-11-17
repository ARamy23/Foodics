//
//  FontFactory.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIFont

public struct FontFactory {
  static func getFont(_ family: FontFamily, _ weight: FontWeight, _ size: CGFloat) -> UIFont {
    return UIFont(name: generateFontName(family, weight), size: size) ?? .systemFont(ofSize: size)
  }
  
  static func getLocalizedFont(_ weight: FontWeight, _ size: CGFloat) -> UIFont {
    switch UserSettingsService.shared.language.value ?? .english {
    case .english:
      return getFont(.poppins, weight, size)
    case .arabic:
      return getFont(.cairo, weight, size)
    }
  }
  
  private static func generateFontName(_ family: FontFamily, _ weight: FontWeight) -> String {
    return "\(family.rawValue)\(weight.rawValue)"
  }
}

public enum FontFamily: String {
  /// English Font
  case poppins = "Poppins-"
  
  /// Arabic Font
  case cairo = "Cairo-"
}

public enum FontWeight: String {
  case extraLight = "ExtraLight"
  case light = "Light"
  case regular = "Regular"
  case black = "Black"
  case bold = "Bold"
  case semiBold = "SemiBold"
}
