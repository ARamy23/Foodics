//
//  PasswordTextField.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/13/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

final class PasswordTextField: BasicTextField {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

private extension PasswordTextField {
  func initialize() {
    setupViews()
  }
  
  func setupViews() {
    self.textField.textContentType = .oneTimeCode
    let passwordHintLocked = R.string.localizables.password_hint_locked()
    self.isSecureEntry = true
    self.backgroundColor = .clear
    self.placeholder = passwordHintLocked
    self.helperText = R.string.localizables.your_current_password()
    self.trailingIconImage = #imageLiteral(resourceName: "ic_password_lock")
    self.onTrailingIconTap = {
      self.isSecureEntry.toggle()
      let isSecureEntry = self.isSecureEntry
      let passwordHintUnlocked = R.string.localizables.password_hint_unlocked()
      self.placeholder = isSecureEntry ?? true ? passwordHintLocked : passwordHintUnlocked
      self.trailingIconImage = isSecureEntry ?? true ? #imageLiteral(resourceName: "ic_password_lock") : #imageLiteral(resourceName: "ic_password_unlock")
    }
  }
}
