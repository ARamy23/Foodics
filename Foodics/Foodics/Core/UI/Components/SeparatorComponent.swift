//
//  SeparatorComponent.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import Carbon

public struct SeparatorComponent: IdentifiableComponent {
  
  public var id: String {
    return "SeparatorComponent"
  }

  private let leadingSpacingView = UIView().then {
    $0.backgroundColor = .clear
  }
  
  private let leading: Bool
  
  public init(leading: Bool) {
    self.leading = leading
  }
  
  public func renderContent() -> UIStackView {
    let hStackView = UIStackView(axis: .horizontal, spacing: 0)
    
    let separatorView = UIView().then {
      $0.backgroundColor = R.color.separatorColor()
    }
    
    hStackView.addArrangedSubview(leadingSpacingView)
    hStackView.addArrangedSubview(separatorView)
    
    leadingSpacingView.snp.makeConstraints { make in
      make.width.equalTo(Configurations.UI.Spacing.p3)
    }
    
    return hStackView
  }
  
  public func layout(content: UIStackView, in container: UIView) {
    container.addSubview(content)
    
    content.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.height.equalTo(1)
    }
  }
  
  public func render(in content: UIStackView) {
    leadingSpacingView.isHidden = !leading
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    CGSize(width: bounds.width, height: 1)
  }
}

