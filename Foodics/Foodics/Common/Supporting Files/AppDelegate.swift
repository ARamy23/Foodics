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
    [
      ReportPlugin(),
      UtilsPlugin(),
      AppearancePlugin()
    ]
  }
}


