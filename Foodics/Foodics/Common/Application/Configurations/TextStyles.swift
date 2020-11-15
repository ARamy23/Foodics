//
//  TextStyles.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIFont

/// Enum with static fonts that matches HGI's metrics
enum TextStyles {
  static let headlineFont: UIFont = FontFactory.getLocalizedFont(.semiBold, 17)
  static let buttonFont: UIFont = FontFactory.getLocalizedFont(.semiBold, 15)
  static let title1Font: UIFont = FontFactory.getLocalizedFont(.semiBold, 22)
  static let title2Font: UIFont = FontFactory.getLocalizedFont(.semiBold, 20)
  static let caption1Font: UIFont = FontFactory.getLocalizedFont(.regular, 12)
  static let caption2Font: UIFont = FontFactory.getLocalizedFont(.regular, 11)
  static let caption3Font: UIFont = FontFactory.getLocalizedFont(.regular, 10)
  static let caption4Font: UIFont = FontFactory.getLocalizedFont(.light, 11)
  static let bodyFont: UIFont = FontFactory.getLocalizedFont(.regular, 17)
  static let calloutFont: UIFont = FontFactory.getLocalizedFont(.regular, 16)
}
