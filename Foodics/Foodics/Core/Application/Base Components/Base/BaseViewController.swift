//
//  BaseViewController.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import SnapKit
import PKHUD

open class BaseViewController: UIViewController, LoadableViewController {
  var router: RouterProtocol = Router()
  
  let vStackView = UIStackView(axis: .vertical, spacing: 0)
  
  let spacingView = UIView().then {
    $0.backgroundColor = R.color.primaryBackgroundColor()
  }
  
  var isDidAppeared = false
  var isWillAppeared = false
  open var showTopSpacingView: Bool {
    return true
  }
  
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(vStackView)

    vStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    
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
    
    guard showTopSpacingView else { return }
    if navigationController != nil {
      spacingView.removeFromSuperview()
      vStackView.insertArrangedSubview(spacingView, at: .zero)
      spacingView.snp.remakeConstraints { $0.height.equalTo(16) }
    }
  }
  
  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    HUD.hide()
  }
}
