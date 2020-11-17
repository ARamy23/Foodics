//
//  EmptyStateComponent.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import Carbon

public struct EmptyStateComponent: IdentifiableComponent {

  private let viewModel: EmptyStateViewModelProtocol

  public init(with type: ViewType, buttonOnTap: @escaping VoidCallback = { }) {
    self.viewModel = type.build(buttonOnTap)
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    return bounds.size
  }

  public func render(in content: EmptyStateView) {
    content.configure(with: viewModel)
  }

  public func renderContent() -> EmptyStateView {
    return EmptyStateView()
  }
}

public extension EmptyStateComponent {
  enum ViewType {
    case noCategories
      
    func build(_ buttonOnTap: @escaping VoidCallback = { }) -> EmptyStateViewModelProtocol {
      switch self {
      case .noCategories:
        return EmptyStateViewModel(
          title: "We couldn't find any categories 🤨, care to try again? 😊",
          subtitle: "It's propably a fluke...",
          image: nil,
          buttonText: "Try again",
          buttonOnTap: buttonOnTap)
      }
    }
  }
}
