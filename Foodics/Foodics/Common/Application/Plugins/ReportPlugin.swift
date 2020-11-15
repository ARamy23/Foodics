//
//  ReportPlugin.swift
//  Foodics
//
//  Created by Ahmed Ramy on 9/30/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIApplication

struct ReportPlugin { }

extension ReportPlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    // Add Reporting Tools here like Sentry, Bugsnag, Smartlook
    return true
  }
}
