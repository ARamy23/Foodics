//
//  SceneDelegate.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/15/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class SceneDelegate: ScenePluggableDelegate { }

extension SceneDelegate {
  override func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    guard let scene = scene as? UIWindowScene else { return }
    // Build and assign main window
    window = UIWindow(windowScene: scene)
    defer { window?.makeKeyAndVisible() }
    set(rootViewTo: MenuViewController())
  }
}

// MARK: - Helpers

private extension SceneDelegate {
  
  /// Assign root view to window. Adds any environment objects if needed.
  func set<T: UIViewController>(rootViewTo view: T) {
    window?.rootViewController = view
  }
}
