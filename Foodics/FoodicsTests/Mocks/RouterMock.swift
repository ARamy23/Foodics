//
//  RouterMock.swift
//  FoodicsTests
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation
import UIKit

@testable import Foodics

enum RoutingAction: Equatable {
  case present(_ vc: UIViewController.Type)
  case push(_ vc: UIViewController.Type)
  case activityStart
  case activityStop
  case dismiss
  case pop
  case popToRoot
  case popToVC
  case popTo(_ vc: UIViewController.Type)
  case alert(_ message: String)
  case gaveAnAlert
  case alertWithAction((title: String, message: String))
  case showInfo(_ message: String)
  case gaveAToast
  
  static public func ==(lhs: RoutingAction, rhs: RoutingAction) -> Bool {
    switch (lhs, rhs) {
    case let (.popTo(a), .popTo(b)): return a == b
    case let (.present(a), .present(b)): return a == b
    case let (.push(a), .push(b)): return a == b
    case let (.alert(a), .alert(b)): return a == b
    case let (.showInfo(a), .showInfo(b)): return a == b
    case let (.alertWithAction(a), .alertWithAction(b)):
      return a.title == b.title && a.message == b.message
    case (.activityStart, .activityStart),
         (.activityStop, .activityStop),
         (.dismiss, .dismiss),
         (.pop, .pop),
         (.gaveAnAlert, .gaveAnAlert),
         (.gaveAToast, .gaveAToast),
         (.popToRoot, .popToRoot),
         (.popToVC, .popToVC):
      return true
    default:
      return false
    }
  }
}

final class RouterMock: RouterProtocol {
  weak var presentedView: BaseViewController!
  var actions: [RoutingAction] = []
  var alertActions: [AlertAction] = []
  
  func popToRoot() {
    actions.append(.popToRoot)
  }
  
  func popTo(vc: UIViewController) {
    actions.append(.popToVC)
  }
  
  func push(_ view: UIViewController) {
    actions.append(.push(type(of: view)))
  }
  
  func present(_ view: UIViewController) {
    actions.append(.present(type(of: view)))
  }
  
  func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
    self.actions.append(.gaveAnAlert)
    self.actions.append(.alert(message))
  }
  
  func alert(error: Error) {
    alert(title: "Error", message: error.localizedDescription, actions: [("Ok", .default)])
  }
  
  func startActivityIndicator() {
    self.actions.append(.activityStart)
  }
  
  func stopActivityIndicator() {
    self.actions.append(.activityStop)
  }
  
  func dismiss() {
    self.actions.append(.dismiss)
  }
  
  func alertWithAction(title: String?, message: String?, alertStyle: UIAlertController.Style, tintColor: UIColor?, actions: [AlertAction]) {
    self.actions.append(.gaveAnAlert)
    self.actions.append(.alertWithAction((title ?? "", message ?? "")))
    self.alertActions.append(contentsOf: actions)
  }
  
  func pop(animated: Bool) {
    self.actions.append(.pop)
  }
  
  func showInfo(title: String, message: String) {
    actions.append(.gaveAToast)
  }
}
