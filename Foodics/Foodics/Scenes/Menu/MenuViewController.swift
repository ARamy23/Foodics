//
//  MenuViewController.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class MenuViewController: ListableViewController, BindableType {
  var viewModel: MenuViewModel!
  lazy var pullToRefreshPlugin: PullToRefreshPlugin = .init(tableView: self.tableView) {
    self.viewModel.refreshMenu()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  
  override func viewWillAppearOnce(_ animated: Bool) {
    super.viewWillAppearOnce(animated)
    bindViewModel()
  }
  
  func bindViewModel() {
    viewModel.state.subscribe {
      switch $0 {
      case .render(let sections):
        self.renderer.render(sections)
        self.pullToRefreshPlugin.stopRefreshing()
      case .showPopup(let product):
        // TODO: - Show Popup
        break
      case .initial:
        break
      }
    }
  }
}
