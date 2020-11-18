//
//  AppDelegate.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/15/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: ApplicationPluggableDelegate {
  override func plugins() -> [ApplicationPlugin] {
    guard !isUnitTesting else { return [] }
    return [
      CorePlugin(),
      ReportPlugin(),
      UtilsPlugin(),
      AppearancePlugin()
    ]
  }
}

private extension AppDelegate {
  var isUnitTesting: Bool {
    return ProcessInfo.processInfo.arguments.contains("-UNITTEST")
  }
}

