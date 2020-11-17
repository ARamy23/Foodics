//
//  TextStyles.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIFont

/// Enum with static fonts that matches HGI's metrics
public enum TextStyles {
  /// semiBold, 17
  public static let headlineFont: UIFont = FontFactory.getLocalizedFont(.semiBold, 17)
  /// semiBold, 15
  public static let buttonFont: UIFont = FontFactory.getLocalizedFont(.semiBold, 15)
  /// semiBold, 22
  public static let title1Font: UIFont = FontFactory.getLocalizedFont(.semiBold, 22)
  /// semiBold, 20
  public static let title2Font: UIFont = FontFactory.getLocalizedFont(.semiBold, 20)
  /// regular, 12
  public static let caption1Font: UIFont = FontFactory.getLocalizedFont(.regular, 12)
  /// regular, 11
  public static let caption2Font: UIFont = FontFactory.getLocalizedFont(.regular, 11)
  /// regular, 10
  public static let caption3Font: UIFont = FontFactory.getLocalizedFont(.regular, 10)
  /// light, 11
  public static let caption4Font: UIFont = FontFactory.getLocalizedFont(.light, 11)
  /// regular, 17
  public static let bodyFont: UIFont = FontFactory.getLocalizedFont(.regular, 17)
  /// regular, 16
  public static let calloutFont: UIFont = FontFactory.getLocalizedFont(.regular, 16)
}
