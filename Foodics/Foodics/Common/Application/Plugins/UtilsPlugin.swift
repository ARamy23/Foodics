//
//  UtilsPlugin.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import IQKeyboardManagerSwift
import SwifterSwift

struct UtilsPlugin { }

extension UtilsPlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    addKeyboardUtils()
    return true
  }
  
  private func addKeyboardUtils() {
    IQKeyboardManager.shared.enable = true
  }
}
