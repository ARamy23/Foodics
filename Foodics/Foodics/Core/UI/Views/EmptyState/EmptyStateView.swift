//
//  EmptyStateView.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public final class EmptyStateView: UIView {
  internal let imageView = UIImageView()
  
  internal let titleLabel = Label(font: TextStyles.headline, color: .black).then {
    $0.adjustsFontSizeToFitWidth = true
    $0.textAlignment = .center
    $0.numberOfLines = 1
    $0.lineBreakMode = .byWordWrapping
  }
  
  internal let subtitleLabel = Label(font: TextStyles.body, color: .darkGray).then {
    $0.adjustsFontSizeToFitWidth = true
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.lineBreakMode = .byWordWrapping
  }
  
  internal let button = Button().then {
    $0.tintColor = .white
    $0.layer.cornerRadius = 13
    $0.backgroundColor = R.color.primaryButtonBackgroundColor()
  }
  
  internal let vStackView = UIStackView(
    axis: .vertical,
    alignment: .center,
    distribution: .fill,
    spacing: 18
  )
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
  
  public func configure(with viewModel: EmptyStateViewModelProtocol) {
    imageView.image = viewModel.image
    titleLabel.text(viewModel.title)
    subtitleLabel.text(viewModel.subtitle)
    if let buttonText = viewModel.buttonText, let buttonOnTap = viewModel.buttonOnTap {
      self.button.type = .text(buttonText, style: PrimaryButtonStyle())
      self.button.setControlEvent(.touchUpInside, buttonOnTap)
    } else {
      self.button.isHidden = true
    }
  }
}
// MARK: - Private

private extension EmptyStateView {
  func initialize() {
    setupViews()
    setupConstraints()
  }

  func setupViews() {
    vStackView.setArrangedSubview(imageView, titleLabel, subtitleLabel, button)
    addSubview(vStackView)
  }

  func setupConstraints() {
    vStackView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(27)
    }
    
    button.snp.makeConstraints { (make) in
      make.height.equalTo(52)
    }
  }
}

