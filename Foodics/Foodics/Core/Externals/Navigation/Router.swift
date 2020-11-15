//
//  Router.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

final class Router: RouterProtocol {
  weak var presentedView: BaseViewController!
  
  func present(_ view: UIViewController) {
    presentedView?.present(view, animated: true, completion: nil)
  }
  
  func startActivityIndicator() {
    presentedView?.startLoading()
  }
  
  func stopActivityIndicator() {
    presentedView?.stopLoading()
  }
  
  func dismiss() {
    presentedView?.dismiss(animated: true, completion: nil)
  }
  
  func pop() {
    
  }
  
  func pop(animated: Bool) {
    _ = presentedView?.navigationController?.popViewController(animated: animated)
  }
  
  func popToRoot() {
    _ = presentedView?.navigationController?.popToRootViewController(animated: true)
  }
  
  func popTo(vc: UIViewController) {
    _ = presentedView?.navigationController?.popToViewController(vc, animated: true)
  }
  
  func push(_ view: UIViewController) {
    presentedView?
      .navigationController?
      .pushViewController(view, animated: true)
  }
  
  func alert(error: Error) {
    alert(title: "Error", message: error.localizedDescription, actions: [("Ok", .default)])
  }
  
  func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions
      .map {
        UIAlertAction(title: $0.title, style: $0.style, handler: nil)
    }
    .forEach {
      alert.addAction($0)
    }
    presentedView?.present(alert, animated: true)
  }
  
  func alertWithAction(title: String?,
                       message: String?,
                       alertStyle: UIAlertController.Style,
                       tintColor: UIColor?,
                       actions: [AlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
    actions.map { action in
      UIAlertAction(title: action.title, style: action.style, handler: { (_) in
        action.action()
      })
    }.forEach {
      alert.addAction($0)
    }
    
    if let tintColor = tintColor {
      alert.view.tintColor = tintColor
    }
    
    presentedView?.present(alert, animated: true)
  }
  
  func showInfo(title: String, message: String) {
    // TODO: - Show Info
  }
}
