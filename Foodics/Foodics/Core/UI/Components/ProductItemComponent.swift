//
//  ProductItemComponent.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/22/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon

public struct ProductItemComponent: IdentifiableComponent {
  public let id: String
  private let viewModel: ProductItemViewModelProtocol
  
  public init(id: String, viewModel: ProductItemViewModelProtocol) {
    self.id = id
    self.viewModel = viewModel
  }
  
  public func renderContent() -> ProductItemView {
    ProductItemView()
  }
  
  public func render(in content: ProductItemView) {
    content.configure(with: viewModel)
  }
}
