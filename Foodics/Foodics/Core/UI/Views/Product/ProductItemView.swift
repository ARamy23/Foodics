//
//  ProductItemView.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/22/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import Nuke

public final class ProductItemView: UIView, Configurable {
  let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  let nameLabel = Label(font: TextStyles.body, color: . black).then {
    $0.numberOfLines = 0
  }
  
  lazy var vStack = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 8).then {
    $0.setArrangedSubview([
      self.imageView,
      self.nameLabel
    ])
  }
  
  public func configure(with viewModel: ProductItemViewModelProtocol) {
    if let imageURL = URL(string: viewModel.name) {
      Nuke.loadImage(with: imageURL, into: imageView)
    } else {
      imageView.isHidden = true
    }
    
    nameLabel.text = viewModel.name
    
    self.addGestureRecognizer(UITapGestureRecognizer {
      viewModel.onTapAction()
    })
  }
  
  public init() {
    super.init(frame: .zero)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

private extension ProductItemView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(vStack)
  }
  
  func setupConstraints() {
    vStack.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
      make.height.equalTo(150)
    }
  }
}
