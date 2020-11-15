//
//  NavigationBar+Utils.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIViewController

public enum NavigationLayoutType {
  case leading
}

public protocol NavigationBarViewModelProtocol {
  var layout: NavigationLayoutType { get }
  var title: String { get }
  var buttonOnTap: VoidCallback? { get }
}

public struct NavigationBarViewModel: NavigationBarViewModelProtocol {
  public let layout: NavigationLayoutType
  public let title: String
  public let buttonOnTap: VoidCallback?

  public init(
    layout: NavigationLayoutType,
    title: String,
    buttonOnTap: @escaping VoidCallback = { }
  ) {
    self.layout = layout
    self.title = title
    self.buttonOnTap = buttonOnTap
  }
}

protocol NavigationComponentProtocol {
  func addNavigationItem(with components: [NavigationComponentType], handler: @escaping Callback<NavigationComponentType>)
}

public enum NavigationComponentType {
  case text(NavigationBarViewModelProtocol)
}

extension NavigationComponentProtocol where Self: UIViewController {
  func addNavigationItem(with components: [NavigationComponentType], handler: @escaping Callback<NavigationComponentType>) {
    components.forEach {
      switch $0 {
      case .text(let layoutType):
        text(viewModel: layoutType, handler: handler)
      }
    }
  }
}

// MARK: - Text
private extension NavigationComponentProtocol where Self: UIViewController {
  func text(viewModel: NavigationBarViewModelProtocol, handler: @escaping Callback<NavigationComponentType>) {
    switch viewModel.layout {
    case .leading:
      navigationItem.leftBarButtonItem = .init(customView: textView(viewModel: viewModel))
      navigationItem.leftItemsSupplementBackButton = true
    }
  }
  
  func textView(viewModel: NavigationBarViewModelProtocol) -> NavigationLabelView {
    let view = NavigationLabelView()
    view.configure(with: viewModel)
    return view
  }
}
