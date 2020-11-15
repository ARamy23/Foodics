//
//  BaseViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/17/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

public protocol LifecycleAware {
  func viewDidLoad()
  func viewWillAppear()
  func viewDidAppear()
  func viewWillDisappear()
  func viewDidDisappear()
}

public extension LifecycleAware {
  func viewDidLoad() { }
  func viewWillAppear() { }
  func viewDidAppear() { }
  func viewWillDisappear() { }
  func viewDidDisappear() { }
}

open class BaseViewModel: LifecycleAware {
  var router: RouterProtocol
  
  init(router: RouterProtocol) {
    self.router = router
  }
}
