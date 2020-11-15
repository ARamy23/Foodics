//
//  UIViewController+Extensions.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

extension UIViewController {
  func toggleNavigationBar(show: Bool) {
    navigationController?.setNavigationBarHidden(!show, animated: false)
  }

  func addRightBarButton(text: String, buttonOnTap: @escaping ActionKitVoidClosure) {
    let button = UIBarButtonItem(title: text, actionClosure: buttonOnTap)
    navigationItem.rightBarButtonItem = button
  }
}

// MARK: - Top Most

public extension UIViewController {
  
  class var topMostViewController: UIViewController? {
    var rootViewController: UIViewController?
    if let windowRootViewController = UIApplication.shared.keyWindow?.rootViewController {
      rootViewController = windowRootViewController
    }
    return topMostViewController(of: rootViewController)
  }

  class func topMostViewController(of viewController: UIViewController?) -> UIViewController? {
    // presented view controller
    if let presentedViewController = viewController?.presentedViewController,
      !(presentedViewController is UISearchController) {
      return topMostViewController(of: presentedViewController)
    }

    // UITabBarController
    if let tabBarController = viewController as? UITabBarController,
      let selectedViewController = tabBarController.selectedViewController {
      return topMostViewController(of: selectedViewController)
    }

    // UINavigationController
    if let navigationController = viewController as? UINavigationController,
      let visibleViewController = navigationController.visibleViewController {
      return topMostViewController(of: visibleViewController)
    }

    // UIPageController
    if let pageViewController = viewController as? UIPageViewController,
      pageViewController.viewControllers?.count == 1 {
      return topMostViewController(of: pageViewController.viewControllers?.first)
    }

    // Child view controller
    for subview in viewController?.view?.subviews ?? [] {
      if let childViewController = subview.next as? UIViewController {
        return topMostViewController(of: childViewController)
      }
    }

    return viewController
  }

  class var topMostNavigationController: UINavigationController? {
    let topMostViewController = self.topMostViewController

    if let navigationController = topMostViewController as? UINavigationController {
      return navigationController
    }
    else {
      return topMostViewController?.navigationController
    }
  }

  var isModal: Bool {
    if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
      return false
    } else if presentingViewController != nil {
      return true
    } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
      return true
    } else if tabBarController?.presentingViewController is UITabBarController {
      return true
    } else {
      return false
    }
  }
}
