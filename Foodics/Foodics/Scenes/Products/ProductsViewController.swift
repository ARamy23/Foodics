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
    }
  }
}
