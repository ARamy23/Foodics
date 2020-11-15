//
//  LocalError.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

enum LocalError: Error {
  case genericError
  case invalidEmail
  case passwordTooShort
  case namesCantContainNumbers
  case namesCantContainEmojis
  case namesCantContainSpecialCharacters
  case fieldCantBeEmpty(_ fieldName: String)
}

extension LocalError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .genericError:
      return R.string.localizables.generic_error()
    case .invalidEmail:
      return R.string.localizables.email_not_valid()
    case .passwordTooShort:
      return R.string.localizables.password_too_short()
    case .namesCantContainNumbers:
      return R.string.localizables.names_cant_contain_numbers()
    case .namesCantContainSpecialCharacters:
      return R.string.localizables.names_cant_contain_special_characters()
    case .namesCantContainEmojis:
      return R.string.localizables.names_cant_contain_emojis()
    case .fieldCantBeEmpty(let fieldName):
      return R.string.localizables.field_cant_be_empty(fieldName)
    }
  }
}
