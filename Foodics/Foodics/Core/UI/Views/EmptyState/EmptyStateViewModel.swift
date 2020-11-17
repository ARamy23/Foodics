//
//  EmptyStateViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIImage

public protocol EmptyStateViewModelProtocol {
  var title: String { get set }
  var subtitle: String { get set }
  var image: UIImage? { get set }
  var buttonText: String? { get set }
  var buttonOnTap: VoidCallback? { get set }
}

public struct EmptyStateViewModel: EmptyStateViewModelProtocol {
  public var title: String
  public var subtitle: String
  public var image: UIImage?
  public var buttonText: String?
  public var buttonOnTap: VoidCallback?
  
  public init(
    title: String,
    subtitle: String,
    image: UIImage?,
    buttonText: String? = nil,
    buttonOnTap: VoidCallback? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
    self.image = image
    self.buttonText = buttonText
    self.buttonOnTap = buttonOnTap
  }
}
