//
//  PullToRefreshPlugin.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/22/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public final class PullToRefreshPlugin: Plugin {
  
  private var refreshControl = UIRefreshControl()
  public lazy var stopRefreshing: VoidCallback = {
    return { [weak self] in self?.refreshControl.endRefreshing() }
  }()
  
  private let tableView: UITableView
  private let action: VoidCallback
  
  public init(tableView: UITableView, action: @escaping VoidCallback) {
    self.tableView = tableView
    self.action = action
  }
  
  public func setupPlugin() {
    refreshControl.addControlEvent(.valueChanged) { [weak self] in
      self?.action()
    }
    
    tableView.addSubview(refreshControl)
  }
}
