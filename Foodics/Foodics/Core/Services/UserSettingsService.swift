//
//  UserSettingsService.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

protocol UserSettings {
  var language: Dynamic<Language> { get }
}

final class UserSettingsService: UserSettings {
  static var shared: UserSettings = UserSettingsService()
  
  var language: Dynamic<Language> {
    let deviceLanguageCode = Bundle.main.preferredLocalizations.first
    let deviceLanguage = Language(localeLanguageCode: deviceLanguageCode ?? "en")
    return Dynamic<Language>(deviceLanguage)
  }
}
