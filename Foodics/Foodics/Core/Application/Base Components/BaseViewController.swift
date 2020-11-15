//
//  BaseViewController.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import PKHUD

class BaseViewController: UIViewController, LoadableViewController {
  var router: RouterProtocol = Router()
  var isDidAppeared = false
  var isWillAppeared = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    router.presentedView = self
  }
  
  func startLoading() {
    HUD.show(.systemActivity)
  }
  
  func stopLoading() {
    HUD.hide()
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)


    if !isWillAppeared {
      isWillAppeared = true
      viewWillAppearOnce(animated)
    }
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if !isDidAppeared {
      isDidAppeared = true
      viewDidAppearOnce(animated)
    }
  }

  open func viewDidAppearOnce(_ animated: Bool) {

  }

  open func viewWillAppearOnce(_ animated: Bool) {
    self.view.backgroundColor = R.color.primaryBackgroundColor()
  }
  
  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    HUD.hide()
  }
}
