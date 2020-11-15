//
//  Language.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

enum Language: CaseIterable {
  case arabic
  case english
  
  var languageCode: String {
    switch self {
    case .arabic: return "ar"
    case .english: return "en"
    }
  }
  
  init(_ language: String) {
    switch language {
    case "ar": self = .arabic
    case "en": self = .english
    default: self = .english
    }
  }
  
  init(localeLanguageCode: String) {
    switch localeLanguageCode {
    case "ar": self = .arabic
    case "en": self = .english
    default: self = .english
    }
  }
  
  var isRTLLanguage: Bool {
    return self == .arabic
  }
}
