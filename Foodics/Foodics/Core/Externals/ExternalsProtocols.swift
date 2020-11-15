//
//  ExternalsProtocols.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

protocol ReadableStorage {
    func fetchValue(for key: StorageKey) throws -> Data
    func fetchValue(for key: StorageKey, handler: @escaping Handler<Data>)
}

protocol WritableStorage {
    func save(value: Data, for key: StorageKey) throws
    func save(value: Data, for key: StorageKey, handler: @escaping Handler<Data>)
}

typealias Storage = ReadableStorage & WritableStorage

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
  func call<T: Codable, U: Endpoint>(api: U, model: T.Type, _ onFetch: @escaping (Result<T, Error>) -> Void)
}

