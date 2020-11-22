//
//  ProductsViewController.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class ProductsViewController: ListableViewController, BindableType {
  var viewModel: ProductsViewModel!
  lazy var pullToRefreshPlugin: PullToRefreshPlugin = .init(tableView: self.tableView) {
    self.viewModel.refreshProducts()
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
    viewModel.sections.subscribe {
      self.renderer.render($0)
      self.pullToRefreshPlugin.stopRefreshing()
    }
  }
}
