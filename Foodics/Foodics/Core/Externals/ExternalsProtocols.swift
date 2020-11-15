//
//  ExternalsProtocols.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

protocol CacheProtocol {
  func getData(key: CachingKey) -> [Data]?
  func saveData(_ data: Data, key: CachingKey)
  func getObject<T: Codable>(_ object: T.Type, key: CachingKey) -> T?
  func saveObject<T: Codable>(_ object: T, key: CachingKey)
  func getBool(key: CachingKey) -> Bool?
  func saveBool(value: Bool, key: CachingKey)
  func removeObject(key: CachingKey)
  func flushCache()
}

protocol RouterProtocol: class {
  var presentedView: BaseViewController! { set get }
  func present(_ view: UIViewController)
  func startActivityIndicator()
  func stopActivityIndicator()
  func dismiss()
  func pop(animated: Bool)
  func popToRoot()
  func popTo(vc: UIViewController)
  func push(_ view: UIViewController)
  func showInfo(title: String, message: String)
  func alert(error: Error)
  func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)])
  func alertWithAction(title: String?, message: String?, alertStyle: UIAlertController.Style, tintColor: UIColor?, actions: [AlertAction])
}

protocol NetworkProtocol: class {
  /// Use this when u don't want to deal with the response and parse it urself, rather have the
  /// model parsed inside the network layer and returned to u
  func call<T: Codable, U: Endpoint>(api: U, model: T.Type, _ onFetch: @escaping (Result<T, Error>) -> Void)
}

