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
  public static let headline: UIFont = FontFactory.getLocalizedFont(.semiBold, 17)
  /// semiBold, 15
  public static let button: UIFont = FontFactory.getLocalizedFont(.semiBold, 15)
  /// semiBold, 22
  public static let title1: UIFont = FontFactory.getLocalizedFont(.semiBold, 22)
  /// semiBold, 20
  public static let title2: UIFont = FontFactory.getLocalizedFont(.semiBold, 20)
  /// regular, 12
  public static let caption1: UIFont = FontFactory.getLocalizedFont(.regular, 12)
  /// regular, 11
  public static let caption2: UIFont = FontFactory.getLocalizedFont(.regular, 11)
  /// regular, 10
  public static let caption3: UIFont = FontFactory.getLocalizedFont(.regular, 10)
  /// light, 11
  public static let caption4: UIFont = FontFactory.getLocalizedFont(.light, 11)
  /// regular, 17
  public static let body: UIFont = FontFactory.getLocalizedFont(.regular, 17)
  /// regular, 16
  public static let callout: UIFont = FontFactory.getLocalizedFont(.regular, 16)
}
