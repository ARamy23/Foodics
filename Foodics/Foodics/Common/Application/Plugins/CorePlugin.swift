//
//  CorePlugin.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

struct CorePlugin { }

extension CorePlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    setupServiceLocator()
    return true
  }
  
  private func setupServiceLocator() {
    ServiceLocator.shared = ServiceLocator(
      network: MoyaManager(),
      storage: DiskStorage()
    )
  }
}
