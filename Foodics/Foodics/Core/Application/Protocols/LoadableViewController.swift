//
//  LoadableViewController.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIViewController

protocol LoadableViewController: class {
  func startLoading()
  func stopLoading()
}
