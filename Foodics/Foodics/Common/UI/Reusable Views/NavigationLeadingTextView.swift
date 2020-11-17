//
//  NavigationLeadingTextView.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

final class NavigationLabelView: UIView, ConfigurableProtocol {
  let titleLabel = UILabel().then {
    $0.font = TextStyles.title1
    $0.textColor = R.color.secondaryTextColor()
  }
  
  public func configure(with viewModel: NavigationBarViewModelProtocol) {
    switch viewModel.layout {
    case .leading:
      titleLabel.textAlignment = .natural
    }
    
    titleLabel.text = viewModel.title
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

// MARK: - Private
private extension NavigationLabelView {
  func initialize() {
    setupViews()
    setupConstraints()
  }

  func setupViews() {
    addSubview(titleLabel)
  }

  func setupConstraints() {
    titleLabel.fillToSuperview()
  }
}
