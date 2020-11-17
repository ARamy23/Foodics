//
//  ButtonComponent.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon
import SnapKit

public class ButtonComponent: IdentifiableComponent {
  
  private let type: Button.TypeOfButton
  private let height: CGFloat
  private let onTap: VoidCallback
  private let backgroundColor: UIColor
  private let isEnabled: Bool

  private var heightConstraint: Constraint?
  
  public init(type: Button.TypeOfButton,
              height: CGFloat? = nil,
              backgroundColor: UIColor = .clear,
              isEnabled: Bool = true,
              onTap: @escaping VoidCallback) {
    self.type = type
    self.height = height ?? Dimensions.Buttons.buttonHeight
    self.backgroundColor = backgroundColor
    self.isEnabled = isEnabled
    self.onTap = onTap
  }

  public func shouldRender(next: ButtonComponent, in content: Button) -> Bool {
    return true
  }

  public func renderContent() -> Button {
    return Button()
  }
  
  public func layout(content: Button, in container: UIView) {
    container.addSubview(content)
    container.backgroundColor = backgroundColor
    
    content.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalTo(Configurations.UI.Spacing.p3)
      make.trailing.equalTo(-Configurations.UI.Spacing.p3)
    }
  }

  public func render(in content: Button) {
    content.type = type
    content.isEnabled = isEnabled
    content.setControlEvent(.touchUpInside, onTap)
  }
  
  public func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: height)
  }
}
