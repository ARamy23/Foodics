//
//  Router.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import PopupDialog
import Nuke

public typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

public final class Router: RouterProtocol {
  public weak var presentedView: BaseViewController!
  
  public func present(_ view: UIViewController) {
    presentedView?.present(view, animated: true, completion: nil)
  }
  
  public func startActivityIndicator() {
    presentedView?.startLoading()
  }
  
  public func stopActivityIndicator() {
    presentedView?.stopLoading()
  }
  
  public func dismiss() {
    presentedView?.dismiss(animated: true, completion: nil)
  }
  
  public func pop() {
    
  }
  
  public func pop(animated: Bool) {
    _ = presentedView?.navigationController?.popViewController(animated: animated)
  }
  
  public func popToRoot() {
    _ = presentedView?.navigationController?.popToRootViewController(animated: true)
  }
  
  public func popTo(vc: UIViewController) {
    _ = presentedView?.navigationController?.popToViewController(vc, animated: true)
  }
  
  public func push(_ view: UIViewController) {
    presentedView?
      .navigationController?
      .pushViewController(view, animated: true)
  }
  
  public func alert(error: Error) {
    alert(title: "Error", message: error.localizedDescription, actions: [("Ok", .default)])
  }
  
  public func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
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
  
  public func alertWithAction(title: String?,
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
  
  public func showInfo(title: String, message: String) {
    // TODO: - Show Info Toast
  }
  
  public func popup(viewModel: PopupViewModelProtocol) {
    if let imageURL = viewModel.image.url {
      ImagePipeline.shared.loadImage(with: imageURL, completion: { result in
        guard let image = try? result.get().image else {
          self.showPopup(title: viewModel.title, message: viewModel.description)
          return
        }
        self.showPopup(title: viewModel.title, message: viewModel.description, image: image)
      })
    } else {
      self.showPopup(title: viewModel.title, message: viewModel.description)
    }
  }
  
  private func showPopup(title: String, message: String, image: UIImage? = nil) {
    let popup = PopupDialog(title: title, message: message, image: image)
    self.presentedView.present(popup, animated: true, completion: nil)
  }
}
