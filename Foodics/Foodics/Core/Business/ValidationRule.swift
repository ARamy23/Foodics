//
//  ValidationRule.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

protocol ValidationRule {
  func validate(text: String) -> String?
}

struct EmailRule: ValidationRule {
  func validate(text: String) -> String? {
    return text.isValidEmail ? nil : LocalError.invalidEmail.localizedDescription
  }
}

struct PasswordRule: ValidationRule {
  func validate(text: String) -> String? {
    return text.count < 8 ? LocalError.passwordTooShort.localizedDescription : nil
  }
}

struct NameRule: ValidationRule {
  
  let fieldName: String
  
  func validate(text: String) -> String? {
    guard !text.isEmpty else { return LocalError.fieldCantBeEmpty(fieldName).localizedDescription }
    guard !text.isAlphaNumeric && !text.isNumeric else { return LocalError.namesCantContainNumbers.localizedDescription }
    guard !text.containEmoji else { return LocalError.namesCantContainEmojis.localizedDescription }
    return nil
  }
}
